
local status_ok, buffer_manager = pcall(require,"buffer_manager")
if not status_ok then
    vim.notify("buffer_manager config not loaded")
    return
end

buffer_manager.setup({
    line_keys = "1234567890",  -- deactivate line keybindings
    focus_alternate_buffer = false,
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
    width = 0.8,
    height = 0.3,
})
