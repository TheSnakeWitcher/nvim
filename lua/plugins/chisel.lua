local ok, chisel = pcall(require,"chisel")
if not ok then
    vim.notify "chisel config not loaded"
    return
end


chisel.setup()
