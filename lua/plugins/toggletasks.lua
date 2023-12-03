local status_ok, toggletasks = pcall(require,"toggletasks")
if not status_ok then
    vim.notify "toggletasks config not loaded"
    return
end


--- @help {toggletasks}
toggletasks.setup({
    debug = false,
    silent = false,
    short_paths = true,
    search_paths = {
        'tasks', '.tasks',
        'toggletasks', '.toggletasks',
    },
    scan = {
        global_cwd = true,
        tab_cwd = true,
        win_cwd = true,
        lsp_root = true,
        dirs = {
            vim.fn.stdpath("cache") .. "/toggletasks",
        },
        rtp = false,
        rtp_ftplugin = false,
    },
    tasks = {},
    lsp_priorities = {
        ['null-ls'] = -10,
    },
    toggleterm = {
        close_on_exit = false,
        hidden = true,
    },
    telescope = {
        spawn = {
            open_single = true,
            show_running = false,
            mappings = {
                select_float = '<C-f>',
                spawn_smart = '<C-a>',
                spawn_all = '<M-a>',
                spawn_selected = nil,
            },
        },
        select = {
            mappings = {
                select_float = '<C-f>',
                open_smart = '<C-a>',
                open_all = '<M-a>',
                open_selected = nil,
                kill_smart = '<C-q>',
                kill_all = '<M-q>',
                kill_selected = nil,
                respawn_smart = '<C-s>',
                respawn_all = '<M-s>',
                respawn_selected = nil,
            },
        },
    },
})
