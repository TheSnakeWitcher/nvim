--------------------------------------------------------------
-- documentation
--------------------------------------------------------------


-- notation: vim.[option].VAR_NAME = 'VAR_VALUE'
--
-- vim.bo  : buffer scoped option 
-- vim.wo  : window scoped option
-- vim.to  : tabpage scoped option
-- vim.g   : global scoped variables 
-- vim.v   : predefined vim variables 
-- vim.env : environment scoped variables(environment variables defined in the editor session)


--------------------------------------------------------------
-- user variables
--------------------------------------------------------------
vim.g.mapleader = " "
vim.g.projects_dir = os.getenv("HOME") .. "/SoftwareCode/Projects"
vim.g.snippets_dir = vim.fn.stdpath("config") .. "/luasnippets"
-- vim.g.tasks_dir = vim.fn.stdpath("cache") .. "/toggletasks"
--vim.g.internet = function()
--os.execute("wget google.com --spider")
--end


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
        path =  vim.fn.stdpath("cache") .. "/vimwiki",
        syntax = 'markdown',
        ext = '.md'
    },
}
vim.g.vimwiki_global_ext = 0


--------------------------------------------------------------
-- notify
--------------------------------------------------------------
local ok , _ = pcall(require,"notify")
if ok then vim.notify = require("notify") end
