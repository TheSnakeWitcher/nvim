--- @help {lua-guide-autocommands}

local config = vim.api.nvim_create_augroup("Config", { clear = true })

-- vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "open help window to the right",
    group = config,
    callback = function()
        if vim.bo.ft == "help" then
            vim.cmd.wincmd("L")
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fugitive","git","man", "gitcommit" },
    desc = "open help window to the right",
    group = config,
    command = "wincmd L",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight yanked text",
    group = config,
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
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

vim.api.nvim_create_autocmd("VimResized", {
    desc = "autoresize splits when the terminal window is resized",
    group = config,
    command = "wincmd =",
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "enable features supported by lsp",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- if supported by lsp enable inlay hint
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(
                true, -- not vim.lsp.inlay_hint.is_enabled(),
                { bufnr = args.buf }
            )
        end

        -- "if supported by lsp enable lsp folding",
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        -- builting completion
        -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end

    end
})
