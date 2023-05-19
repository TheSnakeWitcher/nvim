for _, module in ipairs {
    "autocmds.admin",
    "autocmds.config",
    "autocmds.highlight",
    "autocmds.web3",
    "autocmds.projections",
    "autocmds.anvil",
    "autocmds.experimental",
} do
    local ok, _ = pcall(require, module)
    if not ok then
        vim.notify(module  .. " autocmds module not loaded")
    end
end
