local config = vim.api.nvim_create_augroup("Config", { clear = true })

vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
-- vim.cmd("autocmd! BufEnter * if &ft ==# 'markdown' | wincmd L | endif")

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "hot reload options",
    group = config,
    pattern = vim.fn.stdpath("config") .. "/lua/options.lua",
    command = "source <afile>",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "hot reload keymap",
    group = config,
    pattern = vim.fn.stdpath("config") .. "/lua/keymap.lua",
    command = "source <afile>",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = config,
    desc = "when saving a file create directories if needed",
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

--- NOTE: last edited
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = config,
    pattern = { "gitcommit", "markdown" },
    desc = "Set wrap and spell in markdown and gitcommit",
    callback = function(opts)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
