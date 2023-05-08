local ok, codeium = pcall(require,"codeium")
if not ok then
    vim.notify "codeium config not loaded"
    return
end

codeium.setup()
