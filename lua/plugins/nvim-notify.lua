local ok, notify = pcall(require, "notify")
if not ok then
    vim.notify("notify config don't loaded")
    return
end

--- @help {notify.setup()}
notify.setup()
