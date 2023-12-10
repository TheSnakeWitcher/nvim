local ok,_ = require("projections")
if not ok then return end

local Session = require("projections.session")
local Switcher = require("projections.switcher")
local Workspace = require("projections.workspace")

vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    desc =  "Autostore session on VimExit",
    callback = function() Session.store(vim.loop.cwd()) end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.argc() ~= 0 then return end
        local session_info = Session.info(vim.loop.cwd())
        if session_info == nil then
            vim.cmd("Dashboard")
        else
            Session.restore(vim.loop.cwd())
        end
    end,
    desc = "restore last session automatically if exists else show Dashboard",
})
