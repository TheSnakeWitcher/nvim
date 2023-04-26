highlight = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight yanked text",
  group = highlight,
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

--vim.api.nvim_create_augroup("highlighturl", { clear = true }),
--vim.api.nvim_create_autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
--  desc = "URL Highlighting",
--  group = highlight,
--  pattern = "*",
--  callback = function() astronvim.set_url_match() end,
--})
