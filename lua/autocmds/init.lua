for _, module in ipairs {
    "autocmds.config",
    -- "autocmds.nvim-lspconfig",
    "autocmds.projections",
    "autocmds.overseer",
    -- "autocmds.package-info",
} do
    local ok, _ = pcall(require, module)
    if not ok then
        vim.notify(module  .. " autocmds module not loaded")
    end
end
