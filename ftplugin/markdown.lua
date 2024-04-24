-- vim.cmd("autocmd! BufEnter * if &ft ==# 'markdown' | wincmd L | endif")
vim.api.nvim_cmd({ cmd = 'wincmd', args = { 'L' } }, {})

-- vim.cmd("autocmd FileType markdown setlocal spell")
