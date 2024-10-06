local  ok, projections = pcall(require,"projections")
if not ok then
    vim.notify "projections config not loaded"
    return
end

local patterns = {
    git = ".git",
    svn = ".svn",
    hg = ".hg",
    readme = "README.md"
}

local function get_workspaces()
    local workspaces = {
        { vim.g.path.code , { patterns.readme } },
        { vim.g.path.projects , { patterns.git } },
        { vim.g.path.plugin_dev , { patterns.git} },
        { vim.g.path.projects .. "/hardhat" , { patterns.git } },
        { "~/.config/" , { patterns.readme } },
    }

    local path = vim.g.path.work_projects
    for inner_path in vim.fs.dir(path) do
        table.insert(workspaces,{ vim.fs.joinpath(path, inner_path), {} })
    end

    return workspaces
end

--- @help {projections-installation}
projections.setup({
    workspaces = get_workspaces(),
    patterns = { patterns.git , patterns.svn, patterns.hg },
    store_hooks = {
        pre = function()
            if pcall(require, "neo-tree") then
                vim.cmd [[Neotree action=close]]
            end
        end,
        post = nil,
    },
    restore_hooks = {
        pre = nil,
        post = function()
            vim.cmd("Neotree " .. vim.uv.cwd())
        end,
    },
    workspaces_file = vim.fn.stdpath("cache") .. "/projections/workspaces.json",
    sessions_directory = vim.fn.stdpath("cache") .. "/projections/sessions",
})

local Session = require("projections.session")
local Switcher = require("projections.switcher")
local Workspace = require("projections.workspace")

vim.api.nvim_create_user_command("SessionSave", function()
    Session.store(vim.uv.cwd())
end, {})

vim.api.nvim_create_user_command("SessionLoad", function()
    Session.restore(vim.uv.cwd())
end, {})


vim.api.nvim_create_user_command("AddWorkspace", function()
    Workspace.add(vim.uv.cwd())
end, {})

vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    desc =  "Autostore session on VimExit",
    callback = function() Session.store(vim.uv.cwd()) end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.argc() ~= 0 then return end
        local session_info = Session.info(vim.uv.cwd())
        if session_info == nil then
            vim.cmd("Dashboard")
        else
            Session.restore(vim.uv.cwd())
        end
    end,
    desc = "restore last session automatically if exists else show Dashboard",
})
