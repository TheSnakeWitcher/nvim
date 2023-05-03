local ok, zettelkasten = pcall(require,"zettelkasten")
if not ok then
    vim.notify "zettelkasten config not loaded"
    return
end


zettelkasten.setup({
    notes_path = vim.env.HOME .. "/Knowledgebase/zettelkasten"
})
