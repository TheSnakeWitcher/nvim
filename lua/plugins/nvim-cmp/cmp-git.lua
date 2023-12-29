local ok, cmp = pcall(require,'cmp')
if not ok then
    vim.notify("nvim-cmp config don't loaded")
    return
end

local ok, cmp_git = pcall(require,"cmp_git")
if not ok then
    vim.notify "cmp_git config not loaded"
    return
end


--- @help {cmp-git-config}
cmp_git.setup({
    filetypes = { "gitcommit", "octo", "git" },
    remotes = { "origin", "upstream" },
})

--- @help {cmp.setup.filetype}
cmp.setup.filetype({'gitcommit','octo'}, {
    sources = cmp.config.sources({
        { name = 'git' },
        { name = 'buffer' },
    })
})
