local ok, neo_tree = pcall(require, "neo-tree")
if not ok then
    vim.notify "neo-tree config not loaded"
    return
end

--- @help {neo-tree-configuration}
neo_tree.setup({

    buffers = { show_unloaded = true },
    filesystem = { follow_current_file = { enabled = true } },

    --- @help {neo-tree-component-configs}
    default_component_configs = {
        --- @help {neo-tree-git-status}
        git_status = {
            symbols = {
                added     = "",
                modified  = "",
                deleted   = "",
            }
        },
    },

})
