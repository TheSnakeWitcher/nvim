local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
	vim.notify("toggleterm config not loaded")
	return
end

--- @help {toggleterm}
toggleterm.setup()
