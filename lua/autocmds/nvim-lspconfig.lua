local ok,lspconfig = pcall(require,"lspconfig")
if not ok then return end


--- @doc {lspconfig-setup-on_attach}
vim.api.nvim_create_autocmd("LspAttach",{
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(event)
        local bufnr = event.buf

        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
        nmap('<leader><leader>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat')


        vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
            if vim.lsp.buf.format then
                vim.lsp.buf.format()
            elseif vim.lsp.buf.formatting then
                vim.lsp.buf.formatting()
            end
        end, { desc = 'Format current buffer with LSP' })

    end,
})
