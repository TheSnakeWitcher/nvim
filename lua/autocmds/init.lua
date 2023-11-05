for _, module in ipairs {
    "autocmds.admin",
    "autocmds.config",
    -- "autocmds.nvim-lspconfig",
    "autocmds.highlight",
    "autocmds.projections",
    "autocmds.anvil",
    "autocmds.overseer",
    -- "autocmds.package-info",
    "autocmds.experimental",
} do
    local ok, _ = pcall(require, module)
    if not ok then
        vim.notify(module  .. " autocmds module not loaded")
    end
end
