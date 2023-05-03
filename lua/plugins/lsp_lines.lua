local ok, lsp_lines pcall(require,"lsp_lines")
if not ok then
    vim.notify "lsp_lines config not loaded"
    return
end

lsp_lines.setup()
