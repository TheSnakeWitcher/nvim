local ok, forge = pcall(require,"forge")
if not ok then
    vim.notify "forge config not loaded"
    return
end


forge.setup()
