-- vim.cmd("autocmd! BufEnter * if &ft ==# 'markdown' | wincmd L | endif")
vim.api.nvim_cmd({ cmd = 'wincmd', args = { 'L' } }, {})

-- vim.cmd("autocmd FileType markdown setlocal spell")

vim.api.nvim_buf_set_keymap(
    vim.api.nvim_get_current_buf(),
    "i","[[","<esc><cmd>Telekasten insert_link<cr>",
    { desc = "insert link" }
)
