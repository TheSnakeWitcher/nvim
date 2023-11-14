-- vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
vim.api.nvim_cmd({ cmd = 'wincmd', args = { 'L' } }, {})
