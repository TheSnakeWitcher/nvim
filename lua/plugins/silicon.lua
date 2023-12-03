local ok, silicon = pcall(require, "silicon")
if not ok then
	vim.notify("silicon config not loaded")
	return
end

--- @help {silicon.lua-configuration}
silicon.setup({
	theme = "auto",
	output = vim.env.HOME .. "/Pictures/Screenshots/${year}-${month}-${date}_${time}.png",
	font = "Iosevka Term Nerd Font Mono",
	shadowOffsetX = 10,
	shadowOffsetY = 10,
	gobble = true,
	debug = true,
})
