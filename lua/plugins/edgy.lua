local ok, edgy = pcall(require, "edgy")
if not ok then
    vim.notify "edgy config not loaded"
    return
end

--- @help {edgy.nvim-edgy.nvim-configuration}
edgy.setup({
    options = { right = { size = 40 } },
    right = { "trouble" },
})
