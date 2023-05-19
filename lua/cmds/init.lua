for _, module in ipairs({
	"cmds.web3",
	"cmds.peek",
	"cmds.silicon",
	"cmds.nvim-dap-ui",
	"cmds.luasnip",
	"cmds.chisel",
	"cmds.anvil",
}) do
	local ok, _ = pcall(require, module)
	if not ok then
		vim.notify(module .. " cmds not loaded")
    end
end
