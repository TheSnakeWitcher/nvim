local ok, overseer = pcall(require, "overseer")
if not ok then
    vim.notify("overseer config not loaded")
    return
end

--- @help {overseer-options}
overseer.setup({
    dap = false,
    task_list = { direction = "left" },
    form = { win_opts = { winblend = 10 } },
    confirm = { win_opts = { winblend = 10 } },
    task_win = { win_opts = { winblend = 10 } },
    component_aliases = {
        default_vscode = {
            "default",
            "on_result_diagnostics",
            "on_result_diagnostics_quickfix",
        },
        default_neotest = {
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
            "on_complete_dispose",
        }
    },
})

require("plugins.overseer.templates")
require("plugins.overseer.cmds")
