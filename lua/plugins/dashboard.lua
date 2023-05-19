local ok, dashboard = pcall(require, "dashboard")
if not ok then
	vim.notify("dashboard config not loaded")
	return
end

dashboard.setup({
	theme = "hyper",
    disable_move = true,
    shortcut_type = 'letter',  -- options: 'letter' or 'number'
    hide = {
      statusline = false,
      tabline = false,
      winbar = false,
    },
	config = {
        header = require("util.headers").main_header or "[header not available]",
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
				-- action = ":e" .. vim.fn.stdpath("config"),
				action = function()
                    local ok , switcher = pcall(require,"projections.switcher")
                    if not ok then
                        vim.notify("projections not available")
                        return
                    end
                    switcher.switch(vim.fn.stdpath("config"))
                end ,
				key = "c",
			},
			{
				desc = "📦 Projects",
				group = "DiagnosticHint",
				action = "Telescope projections",
				key = "p",
			},
			{
                desc = "累 Update",
                group = "@property",
                action = "PackerSync",
                key = "u"
            },
			{
				icon = "📝 ",
				icon_hl = "@variable",
				desc = "New note",
				group = "Label",
				action = "Telekasten new_note",
				key = "n",
			},
			{
				icon = "🔍 ",
				icon_hl = "@variable",
				desc = "Search notes",
				group = "Number",
				action = "Telekasten find_notes",
				key = "N",
			},
		},
	},
})
