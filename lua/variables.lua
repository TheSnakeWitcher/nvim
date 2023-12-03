--- @help {lua-vim-variables}

--------------------------------------------------------------
-- user variables
--------------------------------------------------------------
vim.g.mapleader = " "
vim.g.knowledgebase_dir = vim.env.HOME .. "/Knowledgebase"
vim.g.code_dir = vim.env.HOME .. "/Code"
vim.g.scripts_dir = vim.g.code_dir .. "/scripts"
vim.g.projects_dir = vim.g.code_dir .. "/projects"
vim.g.work_projects_dir = vim.g.code_dir .. "/work"
vim.g.plugin_dev_dir = vim.g.projects_dir .. "/nvim"
vim.g.snippets_dir = vim.fn.stdpath("config") .. "/luasnippets"

-- local code_dir = vim.env.HOME .. "/Code"
-- local projects_dir = code_dir .. "/projects"
-- vim.g.path = {
--     knowledgebase = vim.env.HOME .. "/Knowledgebase",
--     code = code_dir,
--     scripts = code_dir .. "/scripts",
--     work_projects = code_dir .. "/work",
--     projects = projects_dir,
--     plugin_dev = projects_dir .. "/nvim",
--     snippets = vim.fn.stdpath("config") .. "/luasnippets",
-- }


--------------------------------------------------------------
-- gui variables
--------------------------------------------------------------
-- vim.g.neovide_transparency = 0.9
-- vim.g.neovide_cursor_vfx_mode = "sonicboom"


--------------------------------------------------------------
-- vimwiki
--------------------------------------------------------------
vim.g.vimwiki_list = {
    {
        path =  vim.g.knowledgebase_dir .. "/wiki",
        syntax = 'markdown',
        ext = '.md'
    },
}
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = {
    [".md"] = "markdown",
    [".markdown"] = "markdown",
    ["mdown"] = "markdown",
}


--------------------------------------------------------------
-- vimtex
--------------------------------------------------------------
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'pdfviewer'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_complete_enabled = true
vim.g.vimtex_fold_enabled = true
