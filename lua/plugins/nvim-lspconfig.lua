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

--- @help {neodev-configuration}
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


--- @help {lspconfig-setup-on_attach}
local on_attach = function(client, bufnr)

    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

    nmap('<leader>lr', vim.lsp.buf.rename, '[L]sp [r]ename')
    nmap('<leader>la', vim.lsp.buf.code_action, '[L]sp [A]ction (code actions)')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gR', vim.lsp.buf.references, '[G]oto [R]eferences')
    -- nmap(']]', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[L]sp [s]ymbols')
    nmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]sp [S]ymbols (workspace)')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('<leader>lf', function() vim.lsp.buf.format { async = true } end, '[L]sp [f]ormat')

    -- workspace
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')


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

-- local capabilities = cmp_nvim_lsp.default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

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
            -- filetypes = server_config.filetypes or {},
        })
    else
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

end
