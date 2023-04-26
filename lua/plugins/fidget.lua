local ok, fidget = pcall(require,"fidget")
if not ok then
    vim.notify("fidget config don't loaded")
    return
end


fidget.setup()
