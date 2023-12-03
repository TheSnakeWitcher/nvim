local status_ok, paint = pcall(require, "paint")
if not status_ok then
	vim.notify("paint config not loaded")
	return
end

--- @help {paint.nvim-paint-installation}
paint.setup({
	highlights = {
		{
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%s*(@%w+)",
			hl = "Constant",
		},
		{
			filter = { filetype = "solidity" },
			pattern = "%s*%*%s*(@%w+)",
			hl = "Constant",
		},
		{
			filter = { filetype = "solidity" },
			pattern ="%s*%/%/%/%s*(@%w+)",
			hl = "Constant",
		},
	},
})
