local status_ok, octo = pcall(require, "octo")
if not status_ok then
    vim.notify("octo config not loaded")
    return
end

--- @help {octo-config}
octo.setup()
