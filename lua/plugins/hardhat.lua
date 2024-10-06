local ok, hardhat = pcall(require,"hardhat")
if not ok then
    vim.notify("hardhat config not loaded")
    return
end


--- @help {hardhat-config}
hardhat.setup()
