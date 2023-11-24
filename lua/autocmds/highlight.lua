local highlight = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight yanked text",
    group = highlight,
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})
