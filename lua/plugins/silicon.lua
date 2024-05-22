local ok, silicon = pcall(require, "silicon")
if not ok then
	vim.notify("silicon config not loaded")
	return
end

--- @help {nvim-silicon-setup}
silicon.setup({
	font = "Iosevka Nerd Font",
	theme = "doom-one_dark",
    output = function()
		return string.format(
		    "%s/Pictures/screenshots/%s.png",
		    vim.env.HOME,
            os.date("!%Y-%m-%dT%H-%M-%S")
		)
	end,
})
