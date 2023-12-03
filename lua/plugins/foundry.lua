local ok, foundry = pcall(require,"foundry")
if not ok then
    vim.notify "forge config not loaded"
    return
end


--- @help {foundry}
foundry.setup()
