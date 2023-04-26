local  ok, projections = pcall(require,"projections")
if not ok then
    vim.notify "projections config not loaded"
    return
end

projections.setup({
    workspaces = {                                 -- Default workspaces to search for 
        { "~/SoftwareCode/Projects", { ".git" } }, -- Documents/dev is a workspace. patterns = { ".git" }
        { "~/.config/", {"README.md"} },            -- An empty pattern list indicates that all subdirectories are considered projects
        -- "~/dev",                                  dev is a workspace. default patterns is used (specified below)
    },
    patterns = { ".git", ".svn", ".hg" },          -- Default patterns to use if none were specified. These are NOT regexps.
    -- store_hooks = {
    --      pre = function()
    --             if pcall(require, "neo-tree") then
    --                 vim.cmd [[Neotree action=close]]
    --             end
    --     end,
    --     post = nil,
    --     },
    -- pre and post hooks for restore_session, callable | nil
    -- restore_hooks = {
    --      pre = nil,
    --      post = nil
    -- }, 
    -- workspaces_file = "path/to/file",          -- Path to workspaces json file
    -- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
})

-- Bind <leader>fp to Telescope projections
-- require('telescope').load_extension('projections')
-- vim.keymap.set("n", "<leader>sp", function() vim.cmd("Telescope projections") end)

-- Autostore session on VimExit
local Session = require("projections.session")
local switcher = require("projections.switcher")
--local Workspace = require("projections.workspace")

vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    desc =  "Autostore session on VimExit",
    callback = function() Session.store(vim.loop.cwd()) end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Switch to project if vim was started in a project dir",
    callback = function()
        if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.argc() ~= 0 then return end
        local session_info = Session.info(vim.loop.cwd())
        if session_info == nil then
            Session.restore_latest()
        else
            Session.restore(vim.loop.cwd())
        end
    end,
    desc = "Restore last session automatically"
})

-- vim.api.nvim_create_user_command("StoreProjectSession", function()
--     Session.store(vim.loop.cwd())
-- end, {})
--
-- vim.api.nvim_create_user_command("RestoreProjectSession", function()
--     Session.restore(vim.loop.cwd())
-- end, {})
--
--
-- vim.api.nvim_create_user_command("AddWorkspace", function() 
--     Workspace.add(vim.loop.cwd())
-- end, {})
