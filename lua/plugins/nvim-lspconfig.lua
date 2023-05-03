local ok , mason_lspconfig = pcall(require,"mason-lspconfig")
if not ok then
    vim.notify("mason-lspconfig config not loaded in nvim-lspconfig")
    return
end

local ok , lspconfig = pcall(require,'lspconfig')
if not ok then
    vim.notify("lspconfig not loaded")
    return
end


--------------------------------------------------------------
-- mappings
--------------------------------------------------------------
---Use an on_attach function to only map the following keys
---after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    --local ok, virtualtypes = pcall(require,"virtualtypes")
    --if not ok then
    --    vim.notify("virtualtypes config not loaded in nvim-lspconfig")
    --    return
    --end
    --virtualtypes.on_attach
    --virtualtypes.enable()

    local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[L]ist [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- workspace
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    nmap('<space><space>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat')


    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })

end


--------------------------------------------------------------
-- config servers
--------------------------------------------------------------
local status_ok, neodev = pcall(require,"neodev")
if not status_ok then
    vim.notify "neodev config not loaded in nvim-lspconfig"
    return
end
neodev.setup()

local ok, cmp_nvim_lsp = pcall(require,"cmp_nvim_lsp")
if not ok then
    vim.notify("cmp-nvim-lsp not loaded in" .. vim.fn.expand("%"))
    return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local servers = mason_lspconfig.get_installed_servers()
for _, server in ipairs(servers) do

    local ok , server_config = pcall(require,"plugins.lsp-servers." .. server)
    if ok then
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = server_config.default_config,
            filetype = server_config.filetypes,
        })
    else
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

end
