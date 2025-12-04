local ok, lualine = pcall(require,"lualine")
if not ok then
    vim.notify("lualine config not loaded")
    return {}
end


local diff = util.load_config("lualine.diff")
local project = util.load_config("lualine.project")
-- local tests = util.load_config("lualine.neotest")
local ruler = "%5(%l/%L%):%2c %p%%"  --- @help {statusline}

---@help {lualine-Default-configuration}
lualine.setup({

    options = {
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = { "dashboard" } },
        globalstatus = true,
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { ruler },
        lualine_c = {
            project,
            'branch',
            { "filetype", icon_only = true }, --- @help {lualine-filetype-component-options}
            {
                'filename', --- @help {lualine-filename-component-options}
                path = 1,
                symbols = {
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '', -- 󰗹
                    newfile = '[new]',
                },
            },
            diff, --- @help {lualine-diff-component-options}
            'diagnostics', --- @help {lualine-diagnostics-component-options}
        },
        lualine_x = {
            "overseer",
            -- tests.stats,
        },
        lualine_y = {},
        lualine_z = {}
    },

    -- winbar = {
    --     lualine_c = {
    --         function() return require("lspsaga.symbol.winbar").get_bar() or "" end,
    --     },
    --     lualine_x = {
    --         tests.stats_buf,
    --     },
    -- },

    --- @help {lualine-Available-extensions}
    extensions = {
        "overseer",
    },

})
