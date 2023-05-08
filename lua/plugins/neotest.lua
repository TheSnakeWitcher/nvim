local ok, neotest = pcall(require, "neotest")
if not ok then
	vim.notify "neotest config not loaded"
	return
end

local ok, neotest_go = pcall(require, "neotest-go")
if not ok then
	vim.notify "neotest-go config not loaded"
	return
end

local ok, neotest_rust = pcall(require, "neotest-rust")
if not ok then
	vim.notify "neotest-rust config not loaded"
	return
end

local ok, neotest_plenary = pcall(require, "neotest-plenary")
if not ok then
	vim.notify "neotest-plenary config not loaded"
	return
end

local ok, overseer_consumer = pcall(require, "neotest.consumers.overseer")
if not ok then
	vim.notify "overseer consumer not loaded in neotest config"
	return
end

neotest.setup({
	adapters = {
		neotest_go({
			experimental = {
				test_table = true,
			},
			args = { "-count=1", "-timeout=60s" },
		}),
        neotest_rust({
            args = { "--no-capture"},
            dap_adapter = "lldb",
        }),
        neotest_plenary,
	},
    consumers = {
        overseer = overseer_consumer,
    }
    -- overseer = {
    --     enabled = true,
    --     -- When this is true (the default), it will replace all neotest.run.* commands
    --     force_default = false,
    --   },
})
