local ok, lspsaga = pcall(require,"lspsaga")
if not ok then
    vim.notify "lspsaga config not loaded"
    return
end

--- @help https://nvimdev.github.io/lspsaga/
--- @help {lspsaga.nvim.txt}
lspsaga.setup()
