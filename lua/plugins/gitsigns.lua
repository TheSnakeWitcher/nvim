local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    vim.notify("gitsigns config not loaded")
    return
end

--- @help {gitsigns.setup()}
gitsigns.setup({

    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        changedelete = { text = '' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        untracked    = { text = '┆' },
    },
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author> on <author_time:%Y-%m-%d> : <summary>',

})
