local status_ok, overseer = pcall(require,"overseer")
if not status_ok then
    vim.notify "overseer config not loaded"
    return
end


overseer.setup()
