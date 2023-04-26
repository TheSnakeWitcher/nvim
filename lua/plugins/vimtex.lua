local ok, vimtext = pcall(require,"vimtext")
if not ok then
    vim.notify("vimtext config not loaded")
    return
end


vimtext.setup()
