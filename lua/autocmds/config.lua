local config = vim.api.nvim_create_augroup("Config",{clear = true})

vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
-- vim.cmd("autocmd! BufEnter * if &ft ==# 'markdown' | wincmd L | endif")

vim.api.nvim_create_autocmd("BufWritePost",{
    desc = "hot reload options",
    group = config,
    pattern = vim.fn.stdpath("config") .. "/lua/options.lua",
    command = "source <afile>",
})

vim.api.nvim_create_autocmd("BufWritePost",{
    desc = "hot reload keymap",
    group = config,
    pattern = vim.fn.stdpath("config") .. "/lua/keymap.lua",
    command = "source <afile>",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = config,
    desc = "when saving a file create directories if needed",
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match
        local backup = vim.fn.fnamemodify(file, ":p:~:h")
        backup = backup:gsub("[/\\]", "%%")
        vim.go.backupext = backup
    end,
})
