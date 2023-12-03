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

		--- @doc {neotest-go-installation}
		neotest_go({
			experimental = {
				test_table = true,
			},
			args = { "-count=1", "-timeout=60s" },
		}),

        --- @doc {neotest-rust-neotest-rust}
        neotest_rust({
            args = { "--no-capture"},
            dap_adapter = "lldb",
        }),

        neotest_foundry, --- @doc {neotest-foundry-configuration}
        neotest_hardhat
        -- neotest_plenary,
	},

    consumers = {
        overseer = overseer_consumer,
    },

    default_strategy = "integrated",
    quickfix = {
        enabled = true,
        open = true
    },
})
