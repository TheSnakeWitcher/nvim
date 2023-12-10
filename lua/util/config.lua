local M = {}


M.defaults = {
    open_direction = "float",
    load_direction = "float",
    view_direction = "float",
}

M.overrides = {}


setmetatable(M, {

    __index = function(t,k)
        if M.overrides[k] then
            return M.overrides[k]
        else
            return M.defaults[k]
        end
    end,

    __newindex = function(t, k, v)
        if not M.defaults[k] then
            vim.notify(
                string.format("invalid config field: %s",k),
                vim.log.levels.WARN
            )
        else
            M.overrides[k] = v
        end
    end

})

M.setup = function(opts)
    local newconf = vim.tbl_deep_extend("force",M.defaults,opts or {})
    for k,v in pairs(newconf) do
        M[k] = v
    end
end


return M
