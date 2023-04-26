local status_ok ,rust_tools = pcall(require,"rust-tools")
if not status_ok then
    vim.notify("rust-tools config not loaded")
    return {
        filetypes = {},
        default_config = {},
    }
end

rust_tools.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      --vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

return {
    filetypes = {},
    default_config = {},
}

--------------------------------------------------------------
-- rust server
--------------------------------------------------------------
--lspconfig.rust_analyzer.setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--
--    -- Server-specific settings...
--    settings = {
--      ["rust-analyzer"] = {}
--    }
--}
--
