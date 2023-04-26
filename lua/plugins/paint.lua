local status_ok, paint = pcall(require, "paint")
if not status_ok then
	vim.notify("paint config not loaded")
	return
end

paint.setup({
	---@type PaintHighlight[]
	highlights = {
		{
			-- filter can be a table of buffer options that should match,
			-- or a function called with buf as param that should return true.
			-- The example below will paint @something in comments with Constant
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%s*(@%w+)", --defualt: pattern = "%s*%-%-%-%s*(@%w+)",
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
