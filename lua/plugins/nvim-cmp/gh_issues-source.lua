local Job = require("plenary.job")
local source = {}


source.new = function()
    local self = setmetatable( {cache = {}} , {__index = source})
    return self
end

source.complete = function (self,callback)
    local bufnr = vim.api.nvim_get_current_buf()
    if not self.cache then
        Job:new({
            "gh",
            "issue",
            "list",
            "--limit",
            "1000",
            "--json",
            "title,number,body",

            on_exit = function (job)
                local result = job:result()
                local ok,parsed = pcall(vim.json.decode,table.concat(result,""))
                if not ok then
                    vim.notify "failed to parse github result"
                    return
                end

                local items = {}

                for _ , item in ipairs(parsed) do
                    item.body = string.gsub(item.body or "","\r","")

                    table.insert(items,{
                        label = string.format("#%s",item.number),
                        documentation = {
                            kind = "markdown",
                            value = string.format("# %s\n\n%s",item.title,item.body)
                        },
                    })
                end

                callback = {items = items , isIncomplete = false}
                self.cache[bufnr] = items
            end

        })
        :start()
    else
        callback = {items = self.cache[bufnr] , isIncomplete = false}
    end

end

source.get_trigger_characters = function ()
    return {"#"}
end

source.is_available = function ()
    return vim.bo.filetype == "gitcommit"
end


local ok, cmp = pcall(require,'cmp')
if not ok then
    vim.notify("nvim-cmp not loaded in " .. vim.fn.expand("%:p"))
    return
end
cmp.register_source("gh_issues",source.new())
