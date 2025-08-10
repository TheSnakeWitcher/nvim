local ok, trouble = pcall(require, "trouble")
if not ok then
	vim.notify "trouble config not loaded"
	return
end

---@help {trouble.nvim-trouble-configuration}
trouble.setup({
    win = {
        type = "split",
        position = "right",
        size = 50,
    }
})
