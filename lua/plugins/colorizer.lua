local ok, colorizer = pcall(require,"colorizer")
if not ok then
    vim.notify "colorizer config not loaded"
    return
end

colorizer.setup()
