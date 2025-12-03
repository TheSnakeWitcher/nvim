local  ok, projections = pcall(require,"projections")
if not ok then
    vim.notify "projections config not loaded"
    return
end

local patterns = { git = ".git", readme = "README.md" }

local function get_workspaces()
    local workspaces = {
        { "~/.config/" , { patterns.readme } },
        { vim.g.path.code , { patterns.readme } },
        { vim.g.path.projects , { patterns.git } },
        vim.g.path.test_projects,
    }

    vim.iter({ vim.g.path.work_projects }):each(function(path)
        for inner_path in vim.fs.dir(path) do
            table.insert(
                workspaces,
                { vim.fs.joinpath(path, inner_path), {} }
            )
        end
    end)

    return workspaces
end

--- @help {projections-🛸-projections.nvim-🔌-installation}
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
            vim.cmd("Neotree position=bottom filesystem " .. vim.uv.cwd())
            vim.cmd("Neotree position=top buffers " .. vim.uv.cwd())
        end,
    },
})

local Session = require("projections.session")

vim.api.nvim_create_autocmd('VimLeavePre', {
    desc =  "Autostore session on exit",
    callback = function() Session.store(vim.uv.cwd()) end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "restore last session automatically if exists else show Dashboard",
    callback = function()
        if vim.fn.argc() ~= 0 then return end

        local session_info = Session.info(vim.uv.cwd())
        if session_info == nil then
            vim.cmd("Dashboard")
        else
            Session.restore(vim.uv.cwd())
        end
    end,
})
