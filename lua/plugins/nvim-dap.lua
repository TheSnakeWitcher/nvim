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
nvim_dap_virtual_text.setup()

vim.fn.sign_define("DapBreakpoint", { text = icons.DapBreakpoint, texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.DapBreakpointCondition, texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.DapBreakpointRejected, texthl = "DapBreakpointRejected" })
