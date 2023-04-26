local status_ok, sg = pcall(require,"sg")
if not status_ok then
    vim.notify "sg config not loaded"
    return
end



sg.setup()
  -- Setup the LSP server to attach when you edit an sg:// buffer
  -- Pass your own custom attach function
  --    If you do not pass your own attach function, then the following maps are provide:
  --        - gd -> goto definition
  --        - gr -> goto references
  -- on_attach = your_custom_lsp_attach_function
-- })
