local status_ok , lualine = pcall(require,'lualine')
if not status_ok then
    vim.notify("lualine config not loaded")
    return {}
end

local project = function ()
    local projections_available, Session = pcall(require, 'projections.session')
    if projections_available then
        local info = Session.info(vim.loop.cwd())
        if info ~= nil then
            local project_name = info.project.name
            return '  ' .. project_name
        end
    end
    return vim.fs.basename(vim.loop.cwd())
end

---@help {lualine-Default-configuration}
lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = " ",
        -- section_separators = " ",
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = { "progress","location" },
        lualine_c = {
            project,
            'branch',
            {
                'diff', ---@help {lualine-diff-component-options}
                symbols = {
                    added = ' ',
                    modified = ' ',
                    removed = ' ',
                },
            },
            'diagnostics',
            {
                'filename', ---@help {lualine-filename-component-options}
                symbols = {
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '', -- 󰗹
                    newfile = '[new]', -- 󰎔 , 
                },
            },
            "filetype",
        },
        lualine_x = { "overseer" , "neo-tree"},
        lualine_y = {},
        lualine_z = {}
    },
    ---@help {lualine-Available-extensions}
    extensions = {
        "overseer",
        "neo-tree",
        -- "trouble",
        -- "lazy",
        -- "man",
        -- "mason",obtain 
        -- "neo-tree",
        -- "nvim-dap-ui",
        -- "quickfix",
        -- "toggleterm",
    }
})
