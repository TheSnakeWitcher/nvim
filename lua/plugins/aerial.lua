local ok, aerial = pcall(require, "aerial")
if not ok then
    vim.notify "aerial config not loaded"
    return
end

--- @help {aerial-options}
aerial.setup()
