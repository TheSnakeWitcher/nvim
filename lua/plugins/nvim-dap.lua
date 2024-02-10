local ok, dapui = pcall(require, "dapui")
if not ok then
	vim.notify("nvim-dap-ui config not loaded")
	return
end

--- @help {dapui.setup()}
dapui.setup()


local ok, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not ok then
	vim.notify("nvim-dap-virtual-text config not loaded")
	return
end

--- @help {nvim-dap-virtual-text}
nvim_dap_virtual_text.setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = false,
	display_callback = function(variable, _buf, _stackframe, _node)
		return variable.name .. " = " .. variable.value
	end,
	virt_text_pos = "eol",
	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
})
