for _, module in ipairs({
	"cmds.admin",
	"cmds.projections",
	"cmds.luasnip",
	"cmds.overseer",
	"cmds.silicon",
	"cmds.foundry",
	"cmds.web3",
}) do
	local ok, _ = pcall(require, module)
	if not ok then
		vim.notify(module .. " cmds not loaded")
    end
end
