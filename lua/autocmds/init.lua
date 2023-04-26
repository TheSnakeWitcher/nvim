for _, module in ipairs {
    "autocmds.admin",
    "autocmds.config",
    "autocmds.dashboard",
    "autocmds.highlight",
    "autocmds.web3",
    "autocmds.projections",
    "autocmds.experimental",
} do
    local ok, _ = pcall(require, module)
    if not ok then
        vim.notify(module  .. "autocmds module not loaded")
    end
end
