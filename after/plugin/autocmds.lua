--- @help {lua-guide-autocommands}

vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
-- vim.cmd("autocmd! BufEnter * if &ft ==# 'markdown' | wincmd L | endif")


local config = vim.api.nvim_create_augroup("Config", { clear = true })

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
    desc = "when saving a file create directories if needed",
    group = config,
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Set wrap and spell in markdown and gitcommit filetypes",
    group = config,
    pattern = { "gitcommit", "markdown" },
    callback = function(opts)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})


local highlight = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight yanked text",
    group = highlight,
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(args)
--
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--         if client.server_capabilities.inlayHintProvider then
--             vim.lsp.inlay_hint.enable(
--                 not vim.lsp.inlay_hint.is_enabled(),
--                 { bufnr = args.buf }
--             )
--         end
--
--     end
-- })
