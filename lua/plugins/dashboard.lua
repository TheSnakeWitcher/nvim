local ok, dashboard = pcall(require, "dashboard")
if not ok then
	vim.notify("dashboard config not loaded")
	return
end

dashboard.setup({
	theme = "hyper",
    hide = {
      statusline = false,
      tabline = false,
      winbar = false,
    },
	config = {
		week_header = {
			enable = true,
		},
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
