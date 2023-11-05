for _, module in ipairs({
	"cmds.web3",
	"cmds.projections",
	"cmds.nvim-dap-ui",
	"cmds.luasnip",
	"cmds.overseer",
	"cmds.chisel",
	"cmds.anvil",
	"cmds.silicon",
}) do
	local ok, _ = pcall(require, module)
	if not ok then
		vim.notify(module .. " cmds not loaded")
    end
end
