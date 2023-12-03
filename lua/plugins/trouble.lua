local ok, trouble = pcall(require, "trouble")
if not ok then
	vim.notify "trouble config not loaded"
	return
end

---@help {trouble.nvim-trouble-configuration}
trouble.setup({
	position = "right",
	height = 10,
	width = 60,
	icons = true,
	mode = "workspace_diagnostics",
	fold_open = "",
	fold_closed = "",
	group = true,
	padding = true,
	action_keys = {
		close = "q",
		cancel = "<esc>",
		refresh = "r",
		jump = { "<cr>", "<tab>" },
		open_split = { "<c-x>" },
		open_vsplit = { "<c-v>" },
		open_tab = { "<c-t>" },
		jump_close = { "o" },
		toggle_mode = "m",
		toggle_preview = "P",
		preview = "p",
		hover = "K",
		close_folds = { "zM", "zm" },
		open_folds = { "zR", "zr" },
		toggle_fold = { "zA", "za" },
		previous = "k",
		next = "j",
	},
	indent_lines = true,
	auto_open = false,
	auto_close = false,
	auto_preview = true,
	auto_fold = false,
	auto_jump = { "lsp_definitions" },
	use_diagnostic_signs = true,
})
