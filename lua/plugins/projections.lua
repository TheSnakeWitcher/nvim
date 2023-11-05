local  ok, projections = pcall(require,"projections")
if not ok then
    vim.notify "projections config not loaded"
    return
end


local function get_workspaces()
    local workspaces = {
        { vim.g.projects_dir , { ".git" } },
        { vim.g.projects_dir .. "/nvim" , { ".git" } },
        { vim.g.projects_dir .. "/hardhat" , { ".git" } },
        { vim.g.plugin_dev_dir , { ".git" } },
        { "~/.config/", {"README.md"} },
    }

    local path = vim.g.work_projects_dir
    for inner_path in vim.fs.dir(path) do
        table.insert(workspaces,{ path .. "/" .. inner_path , {} })
    end

    return workspaces
end

--- @doc {projections-installation}
projections.setup({
    workspaces = get_workspaces(),
    patterns = { ".git", ".svn", ".hg" },
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
            vim.cmd("Neotree " .. vim.loop.cwd())
        end,
    },
    workspaces_file = vim.fn.stdpath("cache") .. "/projections/workspaces.json",
    sessions_directory = vim.fn.stdpath("cache") .. "/projections/sessions",
})
