local ok, package_info = pcall(require,"package-info")
if not ok then
    vim.notify "package-info config not loaded"
    return
end


package_info.setup({
    colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
    },
    icons = {
        enable = true,
        style = {
            up_to_date = "|  ",
            outdated = "|  ",
        },
    },
    autostart = true,
    hide_up_to_date = false,
    hide_unstable_versions = false,
    package_manager = "pnpm"
})
