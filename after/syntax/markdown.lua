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

-- render-markdown
vim.cmd("hi RenderMarkdownBullet guifg=#f78c6c")
-- vim.cmd("hi linkRenderMarkdownBullet ObsidianBullet")

-- bullets = { char = "•", hl_group = "ObsidianBullet" },
-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
-- reference_text = { hl_group = "ObsidianRefText" },
-- highlight_text = { hl_group = "ObsidianHighlightText" },
-- tags = { hl_group = "ObsidianTag" },
-- block_ids = { hl_group = "ObsidianBlockID" },
-- hl_groups = {
--   ObsidianTodo = { bold = true, fg = "#f78c6c" },
--   ObsidianDone = { bold = true, fg = "#89ddff" },
--   ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
--   ObsidianTilde = { bold = true, fg = "#ff5370" },
--   ObsidianImportant = { bold = true, fg = "#d73128" },
--   ObsidianBullet = { bold = true, fg = "#89ddff" },
--   ObsidianRefText = { underline = true, fg = "#c792ea" },
--   ObsidianExtLinkIcon = { fg = "#c792ea" },
--   ObsidianTag = { italic = true, fg = "#89ddff" },
--   ObsidianBlockID = { italic = true, fg = "#89ddff" },
--   ObsidianHighlightText = { bg = "#75662e" },

  -- [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
  -- ["~"] = { order = 2, char = "󰰱", hl_group = "ObsidianTilde" },
  -- ["!"] = { order = 3, char = "", hl_group = "ObsidianImportant" },
  -- [">"] = { order = 4, char = "", hl_group = "ObsidianRightArrow" },
  -- ["x"] = { order = 5, char = "", hl_group = "ObsidianDone" },
