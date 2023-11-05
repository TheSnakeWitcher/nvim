local ok, dashboard = pcall(require, "dashboard")
if not ok then
	vim.notify("dashboard config not loaded")
	return
end

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
        -- header = require("util.headers").main_header or "[header not available]",
        -- footer = {},
        packages = { enable = true }, -- show loaded plugins
        project = { enable = true, limit = 4 },
        mru = { limit = 5 },
        -- action = function() vim.cmd('Telescope projections') end, -- executed when <CR> is pressed dashboard
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
				-- action = ":e" .. vim.fn.stdpath("config"),
				action = function()
                    local ok , switcher = pcall(require,"projections.switcher")
                    if not ok then
                        vim.notify("projections not available")
                        return
                    end
                    switcher.switch(vim.fn.stdpath("config"))
                end ,
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
                action = "Lazy update",
            },
			{
				icon = "📝 ",
				icon_hl = "@variable",
				desc = "New note",
				group = "Label",
				key = "n",
				action = "Telekasten new_note",
			},
			{
				icon = "🔍 ",
				icon_hl = "@variable",
				desc = "Search notes",
				group = "Number",
				key = "N",
				action = "Telekasten find_notes",
			},
		},
	},
})
