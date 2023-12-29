local ok, cmp = pcall(require, 'cmp')
if not ok then
    vim.notify("nvim-cmp config don't loaded")
    return
end

cmp.setup.filetype('latex', {
    sources = cmp.config.sources({
        {
            name = "latex_symbols",
            option = { strategy = 2 }, --- @help{cmp-latex-symbols-options}
        },
    })
})
