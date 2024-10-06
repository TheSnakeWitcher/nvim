local ok, foundry = pcall(require,"foundry")
if not ok then
    vim.notify "forge config not loaded"
    return
end

--- @help {foundry}
foundry.setup()

local anvil = foundry.anvil
local chisel = foundry.chisel

vim.api.nvim_create_user_command( "AnvilStart", anvil.start , { desc = "starts a new anvil instance" })
vim.api.nvim_create_user_command("AnvilStop", anvil.stop , { desc = "stop a running anvil instance"})
vim.api.nvim_create_user_command("AnvilStatus", function()
    if anvil.is_running then
        vim.notify("anvil running")
    else
        vim.notify("anvil not running")
    end
end, { desc = "Check if an anvil instance is running"})

vim.api.nvim_create_user_command("Chisel", function(opts)
    local args = opts.fargs
    if #args== 0 then
        chisel.open()
    else
        chisel.load(args[1])
    end
end,{
    desc = "launch a new chisel REPL, if an optional argument {id} was passed loads the corresponding cached session",
    nargs = "?",
})

vim.api.nvim_create_user_command("ChiselView", function(opts) chisel.view(opts.fargs[1]) end, {
    desc = "displays chisel sessions source code with {id}",
    nargs = 1,
})

vim.api.nvim_create_user_command("ChiselClearCache", chisel.clear_cache , {desc = "deletes all cache sessions"})
