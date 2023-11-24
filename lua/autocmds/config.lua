local config = vim.api.nvim_create_augroup("Config",{clear = true})

-- vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })

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

-- vim.api.nvim_create_autocmd("BufWritePost",{
--     desc = "hot compile plugins",
--     group = config,
--     pattern = vim.fn.stdpath("config") .. "/lua/plugins/init.lua",
--     command = "source <afile> | Lazy sync",
-- })

-- vim.api.nvim_create_autocmd("BufWritePost",{
--     desc = "hot reload snippets",
--     group = config,
--     pattern = vim.g.snippets_dir .. "/*.lua",
--     command = "source /home/mr-papi/.config/nvim/lua/plugins/luasnip.lua",
--     callback = vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/plugins/luasnip.lua"),
-- })

-- vim.api.nvim_create_autocmd("CursorHold", {
--   desc = "show line diagnostics",
--   callback = function()
--     if require("plugins.lsp.utils").show_diagnostics() then
--       vim.schedule(vim.diagnostic.open_float)
--     end
--   end,
-- })

-- vim.cmd("autocmd! BufEnter * if &ft ==# 'fugitive' | wincmd L | endif")
