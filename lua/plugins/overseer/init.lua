local ok, overseer = pcall(require, "overseer")
if not ok then
    vim.notify("overseer config not loaded")
    return
end

--- @help {overseer-options}
overseer.setup({
    strategy = "terminal",
    templates = { "builtin" },
    auto_detect_success_color = true,
    dap = false,
    task_list = {
        default_detail = 1,
        max_width = { 100, 0.2 },
        min_width = { 40, 0.1 },
        width = nil,
        separator = "───────────────────────────────────────────",
        direction = "left",
        bindings = {
            ["?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["<C-e>"] = "Edit",
            ["o"] = "Open",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["<C-q>"] = "OpenQuickFix",
            ["p"] = "TogglePreview",
            ["<C-l>"] = "IncreaseDetail",
            ["<C-h>"] = "DecreaseDetail",
            ["L"] = "IncreaseAllDetail",
            ["H"] = "DecreaseAllDetail",
            ["["] = "DecreaseWidth",
            ["]"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
        },
    },
    actions = {},
    form = {
        border = "rounded",
        zindex = 40,
        min_width = 80,
        max_width = 0.9,
        width = nil,
        min_height = 10,
        max_height = 0.9,
        height = nil,
        win_opts = {
            winblend = 10,
        },
    },
    task_launcher = {
        bindings = {
            i = {
                ["<C-s>"] = "Submit",
                ["<C-c>"] = "Cancel",
            },
            n = {
                ["<CR>"] = "Submit",
                ["<C-s>"] = "Submit",
                ["q"] = "Cancel",
                ["?"] = "ShowHelp",
            },
        },
    },
    task_editor = {
        bindings = {
            i = {
                ["<CR>"] = "NextOrSubmit",
                ["<C-s>"] = "Submit",
                ["<Tab>"] = "Next",
                ["<S-Tab>"] = "Prev",
                ["<C-c>"] = "Cancel",
            },
            n = {
                ["<CR>"] = "NextOrSubmit",
                ["<C-s>"] = "Submit",
                ["<Tab>"] = "Next",
                ["<S-Tab>"] = "Prev",
                ["q"] = "Cancel",
                ["?"] = "ShowHelp",
            },
        },
    },
    confirm = {
        border = "rounded",
        zindex = 40,
        min_width = 20,
        max_width = 0.5,
        width = nil,
        min_height = 6,
        max_height = 0.9,
        height = nil,
        win_opts = {
            winblend = 10,
        },
    },
    task_win = {
        padding = 2,
        border = "rounded",
        win_opts = {
            winblend = 10,
        },
    },
    component_aliases = {
        default = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
            "on_complete_dispose",
        },
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
    bundles = {
        save_task_opts = {
            bundleable = true,
        },
    },
    preload_components = {},
    default_template_prompt = "allow",
    template_timeout = 3000,
    template_cache_threshold = 100,
    log = {
        {
            type = "echo",
            level = vim.log.levels.WARN,
        },
        {
            type = "file",
            filename = "overseer.log",
            level = vim.log.levels.WARN,
        },
    },
})

require("plugins.overseer.templates")
