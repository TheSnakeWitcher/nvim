local ok, cmp = pcall(require,'cmp')
if not ok then
    vim.notify("nvim-cmp config don't loaded")
    return
end


local ok, lspkind = pcall(require,'lspkind')
if not ok then
    vim.notify("lspkind config don't loaded")
    return
end


local ok, luasnip = pcall(require,'luasnip')
if not ok then
    vim.notify("luasnip not loaded in nvim-cmp config")
    return
end


--- @help {cmp-config}
cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    formatting = {
        format = function(entry, vim_item)
            -- vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' [' .. vim_item.kind ..  ']'
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = ({
                luasnip = '[snip]',
                -- copilot = '[copilot]',
                -- cmp_ai = '[ai]',
                nvim_lsp = '[lsp]',
                buffer = '[buf]',
                path = '[path]',
                nvim_lua = '[nvim]',
            })[entry.source.name]
            return vim_item
        end,
    },

    sources = cmp.config.sources({
        { name = 'luasnip' , priority = 1000 },
        -- { name = 'codeium' , priority = 1000 },
        -- { name = 'copilot' , priority = 1000 },
        -- { name = 'cmp_ai' , priority = 1000 },
        { name = 'nvim_lsp' , priority = 750 },
        { name = 'nvim_lua' , priority = 750 }, -- by default active only in lua files
        { name = 'buffer' , priority = 500 },
        { name = 'path' , keyworkd_length = 2 , priority = 250 },
        { name = 'calc' },
    }),

    mapping = {

        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm({
            behabior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),

        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),

        ["<C-n>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() and not cmp.visible() then
                luasnip.change_choice(1)
            elseif cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end,{"i","s"}),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() and not cmp.visible() then
                luasnip.change_choice(-1)
            elseif cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end,{"i","s"}),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end,{"i","s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,{"i","s"}),
    },

    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },

    experimental = {
        ghost_text = true, -- put virtual text of current suggestion in front of cursor
    }

})


--------------------------------------------------------------
-- sources
--------------------------------------------------------------

local cmp_dir = "plugins.nvim-cmp."
require(cmp_dir .. 'cmp-cmdline')
require(cmp_dir .. 'cmp-git')
require(cmp_dir .. 'cmp-latex')
-- require(cmp_dir .. 'cmp-otter')
