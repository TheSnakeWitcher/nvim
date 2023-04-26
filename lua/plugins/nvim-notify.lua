local status_ok, notify = pcall(require,"notify")
if not status_ok then
    vim.notify("notify config don't loaded")
    return
end

notify.setup({
    background_colour = "Normal",
    render = "default",
    stages = "slide",   -- fade_in_slide_out",
})
