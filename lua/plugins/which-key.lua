local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	vim.notify("which key config not loaded")
	return
end


--- @help {which-key.nvim-which-key-configuration}
which_key.setup()
