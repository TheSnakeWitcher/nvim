local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	vim.notify("dressing config don't loaded")
	return
end

--- @help {dressing-configuration}
dressing.setup()
