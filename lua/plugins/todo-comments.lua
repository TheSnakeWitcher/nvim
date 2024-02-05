local ok, todo_comments = pcall(require, "todo-comments")
if not ok then
    vim.notify "todo-comments config not loaded"
    return
end

--- @help {todo-comments.nvim-todo-comments-configuration}
todo_comments.setup({

    keywords = {
        FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" } },
        TODO = { icon = "", color = "info" },
        HACK = { icon = "", color = "warning", alt = { "TIP" } },
        WARN = { icon = "", color = "warning", alt = { "WARNING" } },
        PERF = { icon = "󱐋", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰎚", color = "hint", alt = { "INFO", "IMPORTANT" } },
        TEST = { icon = "⏲", color = "test", alt = { "TESTING" } },
    },
    highlight = {
        pattern = {
            [[.*<(KEYWORDS)\s*:]],
            [[.*\@<(KEYWORDS)\s*]], -- vscode-like pattern
        }
    },

})
