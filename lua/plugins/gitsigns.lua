local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    vim.notify("gitsigns config not loaded")
    return
end

--- @help {gitsigns-usage}
gitsigns.setup({
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        changedelete = { text = '' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        untracked    = { text = '┆' },
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_formatter = '<author> on <author_time:%Y-%m-%d> : <summary>',
})
