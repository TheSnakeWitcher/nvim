local ok, icon_picker = pcall(require,"icon-picker")
if not ok then
    vim.notify "icon-picker config not loaded"
    return
end

icon_picker.setup({
    disable_legacy_commands = true
})
