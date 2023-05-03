local  ok, projections = pcall(require,"projections")
if not ok then
    vim.notify "projections config not loaded"
    return
end

projections.setup({
    -- workspaces:
    -- table like { workspace_path , {patterns_table}} containing workspaces to search for
    -- where {patterns_table}:
    --     if empty indicates that all subdirectories are considered projects
    --     if nil default patterns are used (specified in patterns)
    workspaces = {
        { "~/SoftwareCode/Projects", { ".git" } },
        { "~/.config/nvim/lua/plugins/development", { ".git" } },
        { "~/.config/", {"README.md"} },
    },
    patterns = { ".git", ".svn", ".hg" }, -- default patterns to use if none were specified. These are NOT regexps.
    store_hooks = {
         pre = function()
            if pcall(require, "neo-tree") then
                vim.cmd [[Neotree action=close]]
            end
        end,
        post = nil,
    },
    -- pre and post hooks for restore_session, callable | nil
    restore_hooks = {
        pre = nil,
        post = function()
            vim.cmd("Neotree " .. vim.loop.cwd())
        end,
    },
    workspaces_file = vim.fn.stdpath("cache") .. "/projections/workspaces.json", -- Path to workspaces json file
    sessions_directory = vim.fn.stdpath("cache") .. "/projections/sessions",     -- Directory where sessions are stored
})


local Session = require("projections.session")
local Switcher = require("projections.switcher")
-- local Workspace = require("projections.workspace")

vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    desc =  "Autostore session on VimExit",
    callback = function() Session.store(vim.loop.cwd()) end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Switch to project if vim was started in a project dir",
    callback = function()
        if vim.fn.argc() == 0 then Switcher.switch(vim.loop.cwd()) end
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.argc() ~= 0 then return end
        local session_info = Session.info(vim.loop.cwd())
        if session_info == nil then
            vim.cmd("Dashboard")
            -- Session.restore_latest()
        else
            Session.restore(vim.loop.cwd())
        end
    end,
    desc = "restore last session automatically if exists else show Dashboard",
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
