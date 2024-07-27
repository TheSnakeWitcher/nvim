--- @help {syntax}
--- @help {:hi}
vim.cmd("hi link @markup.quote.markdown normal")

vim.cmd("hi @markup.heading.1.markdown cterm=bold gui=bold guifg=#7aa2f7")
vim.cmd("hi @markup.heading.2.markdown cterm=bold gui=bold guifg=#e0af68")
vim.cmd("hi @markup.heading.3.markdown cterm=bold gui=bold guifg=#9ece6a")
vim.cmd("hi @markup.heading.4.markdown cterm=bold gui=bold guifg=#1abc9c")
vim.cmd("hi @markup.heading.5.markdown cterm=bold gui=bold guifg=#bb9af7")
vim.cmd("hi @markup.heading.6.markdown cterm=bold gui=bold guifg=#9d7cd8")

vim.cmd("hi RenderMarkdownH1Bg guibg=#2d344e")
vim.cmd("hi RenderMarkdownH2Bg guibg=#373640")
vim.cmd("hi RenderMarkdownH3Bg guibg=#303940")
vim.cmd("hi RenderMarkdownH4Bg guibg=#233745")
vim.cmd("hi RenderMarkdownH5Bg guibg=#33334e")
vim.cmd("hi RenderMarkdownH6Bg guibg=#30304b")
