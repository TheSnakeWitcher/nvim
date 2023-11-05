local ok, silicon = pcall(require, "silicon")
if not ok then
	vim.notify("silicon config not loaded")
	return
end

--- @doc {silicon.lua-configuration}
silicon.setup({
	theme = "auto",
	output = vim.env.HOME .. "/Pictures/Screenshots/${year}-${month}-${date}_${time}.png",
	bgColor = vim.g.terminal_color_5,
	bgImage = "",
	roundCorner = true,
	windowControls = true,
	lineNumber = true,
	font = "Iosevka Term Nerd Font Mono",
	lineOffset = 1,
	linePad = 2,
	padHoriz = 80,
	padVert = 100,
	shadowBlurRadius = 10,
	shadowColor = "#555555",
	shadowOffsetX = 10,
	shadowOffsetY = 10,
	gobble = true,
	debug = true,
})
