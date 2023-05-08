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
})
