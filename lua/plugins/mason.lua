local ok, mason = pcall(require,"mason")
if not ok then
    vim.notify("mason config not loaded")
    return
end

mason.setup({
    ui = {
        log_level = vim.log.levels.INFO,
        check_outdated_packages_on_open = true,
        max_concurrent_installers = 4,
        border = 'rounded',
        icons = {
            package_installed = "✓",
            package_uninstalled = "✗",
            package_pending = "⟳",
        },
    },
})


local base_servers = {
    "lua_ls",        -- lua
    "bashls",        -- bash
    "solidity",      -- solidity
    "rust_analyzer", -- rust
    "gopls",         -- go
    "julials",       -- julia
    "sqls",          -- sql

    "texlab",        -- latex
    "grammarly",     -- markdown
    "jsonls",        -- json
    "taplo",         -- toml
--    "yamlls",        -- yaml
--    "lemminx",       -- xml
--    "html",          -- html
--    "cssls",         -- css
}


local ok , mason_lspconfig = pcall(require,"mason-lspconfig")
if not ok then
    vim.notify("mason-lspconfig config not loaded")
    return
end

mason_lspconfig.setup({
    ensure_installed = base_servers,
    automatic_installation = false,
})


--local ok , mason_dap = pcall(require,"mason-nvim-dap")
--if not ok then
--    vim.notify("mason-nvim-dap config not loaded")
--    return
--end
--
--mason_dap.setup({
--    --ensure_installed = { "python", "delve" }
--})
