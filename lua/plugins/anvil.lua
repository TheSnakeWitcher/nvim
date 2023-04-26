local ok, anvil = pcall(require,"anvil")
if not ok then
    vim.notify "anvil config not loaded"
    return
end


anvil.setup()
