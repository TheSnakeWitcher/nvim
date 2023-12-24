local ok, sg = pcall(require,"sg")
if not ok then
    vim.notify "sg config not loaded"
    return
end


--- @help {sg.setup}
sg.setup()
