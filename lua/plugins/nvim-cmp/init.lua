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


--------------------------------------------------------------
-- sources
--------------------------------------------------------------
local _ = require('plugins.nvim-cmp.cmp-git')
-- local ok , cmp_git = pcall(require,'plugins.nvim-cmp.cmp-git')
-- if not ok then vim.notify("cmp-git config not loaded") end
-- sources2
-- local ok, _ = pcall(require,'plugins.nvim-cmp.cmp-git')
-- if not ok then
--     vim.notify "cmp-git config not loaded"
--     return
-- end



cmp.setup({

    -- disable completion if the cursor is `Comment` syntax group.
    -- enabled = function()
    --    return not cmp.config.context.in_syntax_group('Comment')
    -- end,

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    formatting = {
        -- format = lspkind.cmp_format(),
        format = function(entry, vim_item)
            -- mode = "symbol_text",
            -- vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' [' .. vim_item.kind ..  ']'
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = '[lsp]',
                luasnip = '[snip]',
                buffer = '[buf]',
                path = '[path]',
                nvim_lua = '[nvim]',
            })[entry.source.name]
            return vim_item
        end,
    },

    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lua' }, -- by default active only in lua files
        { name = 'nvim_lsp' },
        { name = 'git' },
        { name = 'buffer' },
        { name = 'path' , keyworkd_length = 2},
        {
            name = "latex_symbols",
            option = {        -- 0(mixed) :show command and insert symbol
                strategy = 2, -- 1(julia) :show and insert symbol
                              -- 2(latex) :show and insert command
            },
        },
        { name = 'calc' },
    },

    mapping = {

        ["<C-space>"] = cmp.mapping.complete(), --["<C-space>"] = cmp.mapping(cmp.mapping.complete(),{"i","c"}),
        ["<C-y>"] = cmp.mapping.confirm({
            behabior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping(function(fallback) --["<C-n>"] = cmp.mapping.select_next_item(),
            -- if luasnip.choice_active() then
            if luasnip.choice_active() and not cmp.visible() then
                luasnip.change_choice(1)
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,{"i","s"}),
        ["<C-p>"] = cmp.mapping(function(fallback) --["<C-p>"] = cmp.mapping.select_prev_item(),
            -- if luasnip.choice_active() then
            if luasnip.choice_active() and not cmp.visible() then
                luasnip.change_choice(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,{"i","s"}),
        ["<Tab>"] = cmp.mapping(function(fallback) --["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,{"i","s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback) --["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,{"i","s"}),
    },

    experimental = {
        ghost_text = true, -- put virtual text of current suggestion in front of cursor
    }

})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    })
})

-- if you enabled `native_menu`, this won't work anymore
cmp.setup.cmdline({'/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
