local experimental = vim.api.nvim_create_augroup("Experimental", { clear = true })

vim.api.nvim_create_autocmd("FileType",{
    desc = "test experiemental cmp source",
    group = experimental,
    pattern = "lua",
    callback = function()
        local status_ok , cmp = pcall(require,"cmp")
        if not status_ok then
            vim.notify("failed to load cmp in autocmd" .. vim.fn.expand("%"))
            return
        end

        cmp.setup.buffer({
            sources = {
                {name = "month"},
            }
        })
    end
})
