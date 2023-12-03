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
            -- local session_file_path = tostring(info.path)
            -- local project_workspace_patterns = info.project.workspace.patterns
            -- local project_workspace_path = tostring(info.project.workspace)
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
        section_separators = " ",
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {
            "progress","location",
            'branch',
            {
                'diff', ---@doc {lualine-diff-component-options}
                 symbols = {
                    added = ' ',
                    modified = ' ',
                    removed = ' ',
                 },
            },
            'diagnostics',
        },
        lualine_c = {
            project,
            {
                'filename', ---@doc {lualine-filename-component-options}
                 symbols = {
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '', -- 󰗹
                    newfile = '[new]', -- 󰎔 , 
                 },
            },
            "filetype",
        },
        lualine_x = { "overseer" },
        lualine_y = {},
        lualine_z = {}
    },
    ---@doc {lualine-Available-extensions}
    extensions = {
        "overseer",
        -- "trouble",
        -- "lazy",
        -- "neo-tree",
        -- "man",
        -- "mason",obtain 
        -- "neo-tree",
        -- "nvim-dap-ui",
        -- "quickfix",
        -- "toggleterm",
    }
})
