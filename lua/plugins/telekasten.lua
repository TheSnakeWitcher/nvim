local ok, telekasten = pcall(require,"telekasten")
if not ok then
    vim.notify "telekasten config not loaded"
    return
end


telekasten.setup({
    home = vim.fn.stdpath("cache") .. "/telekasten"
})
