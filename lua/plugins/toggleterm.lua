local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
	vim.notify("toggleterm config not loaded")
	return
end

--- @help {toggleterm}
toggleterm.setup({
    size = function(term)
        if term.direction == "horizontal" then
          return 30
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
})
