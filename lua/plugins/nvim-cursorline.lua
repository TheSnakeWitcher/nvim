local ok, cursorline = pcall(require,"nvim-cursorline")
if not ok then
    vim.notify "nvim-cursorline config not loaded"
    return
end

--- @help {nvim-cursorline-usage}
cursorline.setup({
    cursorline = {
        enable = false,
        timeout = 1000,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
})
