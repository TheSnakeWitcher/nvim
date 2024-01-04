local ok , lspconfig = pcall(require,'lspconfig')
if not ok then
    vim.notify("lspconfig not loaded")
    return
end

local ok , mason_lspconfig = pcall(require,"mason-lspconfig")
if not ok then
    vim.notify("mason-lspconfig config not loaded in nvim-lspconfig")
    return
end


------------------------------------------------------------
-- neodev
------------------------------------------------------------
local ok, neodev = pcall(require,"neodev")
if not ok then
    vim.notify "neodev config not loaded in nvim-lspconfig"
    return
end

--- @help {neodev.nvim-neodev.nvim-configuration}
neodev.setup({
    library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
    },
    setup_jsonls = true,
    lspconfig = true,
    pathStrict = true,
})


--- @help {lspconfig-keybindings}
--- @help {lsp-buf}
local on_attach = function(client, bufnr)

    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>lr', vim.lsp.buf.rename, '[L]sp [r]ename')
    nmap('<leader>la', vim.lsp.buf.code_action, '[L]sp [A]ction (code actions)')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gI',  "<cmd>Telescope lsp_implementations<cr>", '[G]oto [I]mplementation')
    nmap('gr', "<cmd>Telescope lsp_references<cr>", '[G]oto [R]eferences')
    nmap('gR', "<cmd>Trouble lsp_references<cr>", '[G]oto [R]eferences')

    nmap('<leader>ls', "<cmd>Telescope lsp_document_symbols<cr>", '[L]sp [s]ymbols')
    nmap('<leader>lS', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", '[L]sp [S]ymbols (workspace)')
    nmap('<leader>lf', function() vim.lsp.buf.format { async = true } end, '[L]sp [f]ormat')

    nmap('<leader>?', vim.lsp.buf.hover, 'Hover Documentation')

    -- workspace
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')


    vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })

end


--------------------------------------------------------------
-- completion capabilities for server
--------------------------------------------------------------
local ok, cmp_nvim_lsp = pcall(require,"cmp_nvim_lsp")
if not ok then
    vim.notify("cmp-nvim-lsp not loaded in" .. vim.fn.expand("%"))
    return
end

--- @help {https://github.com/hrsh7th/cmp-nvim-lsp/issues/38}
--- @help {https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121}
local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    cmp_nvim_lsp.default_capabilities()
)

--- @help {nvim-ufo}
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true --- @help {schemastore-usage}


--------------------------------------------------------------
-- config servers
--------------------------------------------------------------
local servers = mason_lspconfig.get_installed_servers()
for _, server in ipairs(servers) do

    local ok , server_config = pcall(require,"plugins.lsp-servers." .. server)
    if ok then
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = server_config.settings,
        })
    else
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

end
