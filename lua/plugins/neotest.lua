local ok, neotest = pcall(require, "neotest")
if not ok then
    vim.notify "neotest config not loaded"
    return
end

-- local ok, neotest_plenary = pcall(require, "neotest-plenary")
-- if not ok then
-- 	vim.notify "neotest-plenary config not loaded"
-- end

local ok, neotest_go = pcall(require, "neotest-go")
if not ok then
    vim.notify "neotest-go config not loaded"
end

local ok, neotest_rust = pcall(require, "neotest-rust")
if not ok then
    vim.notify "neotest-rust config not loaded"
end

local ok, neotest_foundry = pcall(require, "neotest-foundry")
if not ok then
    vim.notify "neotest-plenary config not loaded"
end


local ok, overseer_consumer = pcall(require, "neotest.consumers.overseer")
if not ok then
    vim.notify "overseer consumer not loaded in neotest config"
end

local ok, neotest_hardhat = pcall(require, "neotest-hardhat")
if not ok then
    vim.notify "neotest-hardhat config not loaded"
end


--- @help {neotest.setup()}
neotest.setup({
    adapters = {

        --- @help {neotest-go-installation}
        neotest_go({
            experimental = {
                test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
        }),

        --- @help {neotest-rust-neotest-rust}
        neotest_rust({
            args = { "--no-capture" },
            dap_adapter = "lldb",
        }),

        --- @help {neotest-foundry-configuration}
        neotest_foundry({
            filterDir = function(name) return name == "test" end,
        }),

        neotest_hardhat  --- @help {neotest-hardhat-setup}
        -- neotest_plenary,

    },
    consumers = {
        overseer = overseer_consumer,
    },
    benchmark = {
        enabled = true
    },
    default_strategy = "integrated",
    diagnostic = {
        enabled = true,
        severity = 1
    },
    discovery = {
        concurrent = 0,
        enabled = true
    },
    floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {}
    },
    highlights = {
        adapter_name = "NeotestAdapterName",
        border = "NeotestBorder",
        dir = "NeotestDir",
        expand_marker = "NeotestExpandMarker",
        failed = "NeotestFailed",
        file = "NeotestFile",
        focused = "NeotestFocused",
        indent = "NeotestIndent",
        marked = "NeotestMarked",
        namespace = "NeotestNamespace",
        passed = "NeotestPassed",
        running = "NeotestRunning",
        select_win = "NeotestWinSelect",
        skipped = "NeotestSkipped",
        target = "NeotestTarget",
        test = "NeotestTest",
        unknown = "NeotestUnknown",
        watching = "NeotestWatching"
    },
    icons = {
        -- https://github.com/nvim-neotest/neotest/discussions/27
        expanded = "╮",
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",

        unknown = "", --   , ,  ,  , 󰼇 , 󰼈 
        skipped = "", --    
        watching = "",
        passed = "", -- 
        failed = "", -- 
        running = "", --     󰐌  󰐊
        running_animated = { "◐", "◓", "◑", "◒"},
    },
    jump = {
        enabled = true
    },
    log_level = 3,
    output = {
        enabled = true,
        open_on_run = "short"
    },
    output_panel = {
        enabled = true,
        open = "botright split | resize 15"
    },
    projects = {},
    quickfix = {
        enabled = true,
        open = true,
    },
    run = {
        enabled = true
    },
    running = {
        concurrent = true
    },
    state = {
        enabled = true
    },
    status = {
        enabled = true,
        signs = true,
        virtual_text = false,
    },
    strategies = {
        integrated = {
            height = 40,
            width = 120
        }
    },
    summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w"
        },
        open = "botright vsplit | vertical resize 50"
    },
    watch = {
        enabled = true,
        symbol_queries = {}
    },
})
