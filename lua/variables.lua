--------------------------------------------------------------
-- documentation
--------------------------------------------------------------


-- notation: vim.[option].VAR_NAME = 'VAR_VALUE'
--
-- vim.b   : buffer scoped variables 
-- vim.w   : window scoped variables
-- vim.t   : tabpage scoped variables
-- vim.g   : global scoped variables 
-- vim.v   : predefined vim variables 
-- vim.env : environment scoped variables(environment variables defined in the editor session)


--------------------------------------------------------------
-- user variables
--------------------------------------------------------------
vim.g.mapleader = " "
vim.g.knowledgebase_dir = vim.env.HOME .. "/Knowledgebase"
vim.g.projects_dir = vim.env.HOME .. "/SoftwareCode/Projects"
vim.g.work_projects_dir = vim.env.HOME .. "/SoftwareCode/Work"
vim.g.plugin_dev_dir = vim.fn.stdpath("config") .. "/lua/plugins/development"
vim.g.snippets_dir = vim.fn.stdpath("config") .. "/luasnippets"


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


--------------------------------------------------------------
-- vimtex
--------------------------------------------------------------
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'pdfviewer'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_complete_enabled = true
vim.g.vimtex_fold_enabled = true


--------------------------------------------------------------
-- notify
--------------------------------------------------------------
local ok , notify = pcall(require,"notify")
if ok then vim.notify = notify end
