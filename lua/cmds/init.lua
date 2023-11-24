for _, module in ipairs({
	"cmds.admin",
	"cmds.projections",
	"cmds.luasnip",
	"cmds.overseer",
	"cmds.nvim-dap-ui",
	"cmds.silicon",
	"cmds.foundry",
	"cmds.web3",
}) do
	local ok, _ = pcall(require, module)
	if not ok then
		vim.notify(module .. " cmds not loaded")
    end
end
