--- @help :highlight , nvim_set_hl , nvim_get_hl

-- vimwiki
vim.cmd("highlight tklink ctermfg=72 guifg=#ecbe7b cterm=bold,underline gui=bold,underline")
vim.cmd("highlight link tkTag xmlTag")


 -- lualine
vim.cmd("hi! link lualine_c_normal Normal")
vim.cmd("hi! link lualine_c_inactive Normal")


 -- gv.nvim
vim.cmd("hi link gvMeta Directory")
vim.cmd("hi link gvGithub Directory")
vim.cmd("hi link gvTag Directory")
vim.cmd("hi link gvDate Label")
vim.cmd("hi link gvAuthor Label")
