local ok, cmp = pcall(require, 'cmp')
if not ok then
    vim.notify("nvim-cmp don't loaded in gitcommit ftplugin")
    return
end

cmp.setup.buffer({
    sources = cmp.config.sources(
        { { name = 'conventionalcommits' } },
        { { name = 'buffer' } }
    ),
})
