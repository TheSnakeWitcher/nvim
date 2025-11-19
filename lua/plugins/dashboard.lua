local ok, dashboard = pcall(require, "dashboard")
if not ok then
    vim.notify("dashboard config not loaded")
    return
end


--- @help {dashboard-configuration}
dashboard.setup({
    theme = "hyper",
    disable_move = true,
    shortcut_type = 'letter',
    hide = {
        statusline = false,
        tabline = false,
        winbar = false,
    },
    config = {
        packages = { enable = true },
        project = { enable = true, limit = 4 },
        mru = { limit = 5 },
        shortcut = {
            {
                icon = "🚪 ",
                desc = "Quit",
                group = "Number",
                action = "q",
                key = "q",
            },
            {
                desc = "🏡 Config",
                icon_hl = "@variable",
                group = "Label",
                key = "c",
                action = function()
                    local ok, switcher = pcall(require, "projections.switcher")
                    if not ok then
                        vim.notify("projections not available")
                        return
                    end
                    switcher.switch(vim.fn.stdpath("config"))
                end,
            },
            {
                icon = "📦 ",
                desc = "Projects",
                group = "DiagnosticHint",
                key = "p",
                action = "Telescope projections",
            },
            {
                icon = "🔼 ",
                desc = "Update",
                group = "@property",
                key = "u",
                action = "Lazy sync",
            },
            {
                icon = "📝 ",
                icon_hl = "@variable",
                desc = "New note",
                group = "Label",
                key = "n",
                action = function()
                    local ok, _ = pcall(require, "obsidian")
                    if not ok then
                        vim.notify("obsidian not available")
                        return
                    end
                    vim.cmd("Obsidian new")
                end,
            },
            {
                icon = "🔍 ",
                icon_hl = "@variable",
                desc = "Search notes",
                group = "Number",
                key = "N",
                action = function()
                    local ok, _ = pcall(require, "obsidian")
                    if not ok then
                        vim.notify("obsidian not available")
                        return
                    end
                    vim.cmd("Obsidian quick_switch")
                end,
            },
        },
    },
})
