latex = vim.api.nvim_create_augroup("Latex",{clear = true})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "automatically compile latex file",
  group = latex,
  pattern = "*.tex",
  --command = "Text",
  --callback = function()
  --end,
})
