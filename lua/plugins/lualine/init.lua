local ok, lualine = pcall(require,"lualine")
if not ok then
    vim.notify("lualine config not loaded")
    return {}
end


local diff = util.load_config("lualine.diff")
local project = util.load_config("lualine.project")
local tests = util.load_config("lualine.neotest")


---@help {lualine-Default-configuration}
lualine.setup({

    options = {
        icons_enabled = true,
        theme = 'onedark', -- 'tokyonight', onedark
        component_separators = { left = '', right = '' }, -- -- ┊ |        
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { "dashboard" },
        },
        globalstatus = true,
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "progress","location" },
        lualine_c = {
            project,
            'branch',
            diff, --- @help {lualine-diff-component-options}
            'diagnostics', --- @help {lualine-diagnostics-component-options}
            {
                'filename', --- @help {lualine-filename-component-options}
                symbols = {
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '', -- 󰗹
                    newfile = '[new]',
                },
            },
            "filetype",
        },
        lualine_x = {
            "overseer",
            tests.stats,
        },
        lualine_y = {},
        lualine_z = {}
    },

    tabline = {
        lualine_a = {
            --- @help {lualine-tabs-component-options}
            {
                "tabs",
                mode = 2,
            }
        },
        lualine_z = {
            --- @help {lualine-windows-component-options}
            {
                "windows",
                mode = 2,
                filetype_names = {
                    ["neo-tree"] = 'Neotree',
                },
                disabled_buftypes = {
                    "prompt",
                    "quickfix",
                    "trouble"
                },
            },
        }
    },

    -- winbar = {
    --     lualine_c = {
    --         function() return require("lspsaga.symbol.winbar").get_bar() or "" end,
    --     },
    --     lualine_x = {
    --         tests.stats_buf,
    --     },
    -- },
    --
    -- inactive_winbar = {
    --     lualine_c = {
    --         function() return require("lspsaga.symbol.winbar").get_bar() or "" end,
    --     },
    --     lualine_x = {
    --          tests.stats_buf,
    --     },
    -- },

    --- @help {lualine-Available-extensions}
    extensions = {
        "overseer",
    },

})
