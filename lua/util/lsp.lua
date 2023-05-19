local M = {}

-- put in on_attach maybe ?
function M.avoid_ts_and_deno_lsp_clash()
    local  denols , tsserver = "denols" , "tsserver"
	local active_clients = vim.lsp.get_active_clients()

	-- stop tsserver if denols is already active
	if client.name == denols then
		for _, client_ in pairs(active_clients) do
			if client_.name == tsserver then
				client_.stop()
			end
		end
    -- prevent tsserver from starting if denols is already active
	elseif client.name == tsserver then
		for _, client_ in pairs(active_clients) do
			if client_.name == denols then
				client.stop()
			end
		end
	end
end


function M.avoid_ts_and_deno_lsp_start_toguether()

    local nvim_lsp = require("nvim-lspconfig")
    nvim_lsp.tsserver.setup{
      on_attach = on_attach,
      capabilities = lsp_capabilities,
      root_dir = nvim_lsp.util.root_pattern("package.json")
    }

    nvim_lsp.denols.setup {
      on_attach = on_attach,
      capabilities = lsp_capabilities,
      root_dir = nvim_lsp.util.root_pattern("deno.json"),
      init_options = {
        lint = true,
      }
    }
end

return M
