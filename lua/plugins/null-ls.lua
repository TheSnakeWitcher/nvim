local ok,null_ls = pcall(require,"null-ls")
if not ok then
    vim.notify("null-ls config not loaded")
    return
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
