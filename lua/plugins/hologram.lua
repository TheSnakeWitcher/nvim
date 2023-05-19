local ok, hologram = pcall(require,"hologram")
if not ok then
    vim.notify "hologram config not loaded"
    return
end

hologram.setup({
    auto_display = true,
})
