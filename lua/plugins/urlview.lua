local status_ok, urlview = pcall(require, "urlview")
if not status_ok then
    vim.notify("urlview config not loaded")
    return
end

--- @help {urlview.config}
urlview.setup({
    default_picker = "telescope",
    default_action = "system",
    jump = {
        prev = "[u",
        next = "]u",
    },

})
