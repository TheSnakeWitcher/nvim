local ok, buffer_manager = pcall(require,"buffer_manager")
if not ok then
    vim.notify("buffer_manager config not loaded")
    return
end


--- @help {buffer_manager.nvim-configuration}
buffer_manager.setup({
    select_menu_item_commands = {
        edit = {
            key = "<CR>",
            command = "edit"
        },
        v = {
            key = "<C-v>",
            command = "vsplit"
        },
        h = {
            key = "<C-h>",
            command = "split"
        }
    },
    width = 80,
    height = 20,
})
