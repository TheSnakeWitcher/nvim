local ok, gitlinker = pcall(require, "gitlinker")
if not ok then
    vim.notify "gitlinker config not loaded"
    return
end


--- @help {gitlinker.nvim-installation}
gitlinker.setup({
    command = {
        name = "GL",
        desc = "Generate git permanent link",
    },
})
