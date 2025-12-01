local ok, edgy = pcall(require, "edgy")
if not ok then
    vim.notify "edgy config not loaded"
    return
end

--- @help {edgy.nvim-edgy.nvim-configuration}
edgy.setup({
    options = { right = { size = 40 } },
    right = { "trouble" },
    left = {
        {
          title = "Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          collapsed = false,
          open = "Neotree position=top buffers",
        },
        {
          title = "Filesystem",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          collapsed = false,
          open = "Neotree position=bottom filesystem",
        },
    },
})
