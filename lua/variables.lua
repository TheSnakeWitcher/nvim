--- @help {lua-vim-variables}

--------------------------------------------------------------
-- user variables
--------------------------------------------------------------
vim.g.mapleader = " "

local code_dir = vim.env.HOME .. "/Code"
vim.g.path = {
    knowledgebase = vim.env.HOME .. "/Knowledgebase",
    code = code_dir,
    scripts = code_dir .. "/scripts",
    work_projects = code_dir .. "/work",
    test_projects = code_dir .. "/test",
    projects = code_dir .. "/projects",
    snippets = vim.fn.stdpath("config") .. "/luasnippets",
}


--------------------------------------------------------------
-- gui variables
--------------------------------------------------------------
-- vim.g.neovide_transparency = 0.9
-- vim.g.neovide_cursor_vfx_mode = "sonicboom"


--------------------------------------------------------------
-- vimtex
--------------------------------------------------------------
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'pdfviewer'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_complete_enabled = true
vim.g.vimtex_fold_enabled = true
