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
        header = util.headers.main_header,
        -- footer = {},
        packages = { enable = true }, -- show loaded plugins
        project = { enable = true, limit = 4 },
        mru = { limit = 5 },
        -- action = function() vim.cmd('Telescope projections') end, -- executed when <CR> is pressed dashboard
		shortcut = {
			{ desc = " Update", group = "@property", action = "PackerSync", key = "u" },
			{
				desc = " Projects",
				group = "DiagnosticHint",
				action = "Telescope projections",
				key = "p",
			},
			{
				desc = " config",
				group = "Number",
				action = ":e" .. vim.fn.stdpath("config"),
				key = "c",
			},
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Note",
				group = "Label",
				action = "Telekasten new_note",
				key = "n",
			},
		},
	},
})
