local ok, bigfile = pcall(require, "bigfile")
if not ok then
    vim.notify("bigfile config not loaded")
    return
end


--- @help {bigfile.nvim-setup}
bigfile.setup({
    filesize = 1,
    pattern = { "*" },
    features = {
        "indent_blankline",
        -- "lsp",
        -- "treesitter",
        -- "syntax",
        -- "matchparen",
        -- "vimopts",
        -- "filetype",
    },
})
