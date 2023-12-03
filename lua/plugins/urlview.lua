local status_ok, urlview = pcall(require, "urlview")
if not status_ok then
    vim.notify("urlview config not loaded")
    return
end


--- @help {urlview.config}
urlview.setup({

    default_title = "Links:",
    default_picker = "telescope",
    default_prefix = "https://",
    default_action = "system",
    unique = true,
    sorted = true,
    log_level_min = vim.log.levels.INFO,
    jump = {
        prev = "[u",
        next = "]u",
    },

})
