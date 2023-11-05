local ok,_ = require("projections")
if not ok then return end

local Session = require("projections.session")
local Switcher = require("projections.switcher")
local Workspace = require("projections.workspace")

vim.api.nvim_create_user_command("SessionSave", function()
    Session.store(vim.loop.cwd())
end, {})

vim.api.nvim_create_user_command("SessionLoad", function()
    Session.restore(vim.loop.cwd())
end, {})


vim.api.nvim_create_user_command("AddWorkspace", function()
    Workspace.add(vim.loop.cwd())
end, {})
