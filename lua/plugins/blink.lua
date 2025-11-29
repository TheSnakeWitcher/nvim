local ok, blink = pcall(require, "blink.cmp")
if not ok then
    vim.notify "blink config not loaded"
    return
end

--- @help {blink-cmp-config}
blink.setup({
    snippets = { preset = 'luasnip' },
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = {
            menu = {
                auto_show = true
                -- auto_show = function(ctx) return vim.fn.getcmdtype() == ':' end,
            }
        },

    },
    sources = {
        default = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            'codeium',
            'git',
            'conventional_commits',
        },
        providers = {
            codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
            git = {
                module = 'blink-cmp-git',
                name = 'Git',
            },
            conventional_commits = {
                name = 'Conventional Commits',
                module = 'blink-cmp-conventional-commits',
                enabled = function()
                    return vim.bo.filetype == 'gitcommit'
                end,
            },
        },
    },

})
