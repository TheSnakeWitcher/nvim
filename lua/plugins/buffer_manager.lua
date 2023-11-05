local status_ok, buffer_manager = pcall(require,"buffer_manager")
if not status_ok then
    vim.notify("buffer_manager config not loaded")
    return
end


buffer_manager.setup({
    line_keys = "1234567890",
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
    focus_alternate_buffer = false,
    short_file_names = false,
    short_term_names = false,
    loop_nav = true,
    highlight = "",
    win_extra_options = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
})
