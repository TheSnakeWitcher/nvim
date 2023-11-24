local ok,foundry = pcall(require,"foundry")
if not ok then return end

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

-- vim.api.nvim_create_user_command(
--     "AnvilAccount",
--     function (opts)
--         local account = anvil.get_account(opts.fargs[1])
--         local row,start_col = vim.api.nvim_win_get_cursor(0)
--         local bufnr = vim.api.nvim_get_current_buf()
--         local end_col = start_col + #account
--         vim.api.nvim_buf_set_text(bufnr,row,start_col,row,end_col,{account})
--     end,{
--         desc = [[
--             get all accounts from a running anvil instance, accept an
--             {index} argument to retrieve a specific account where
--             {index} < configured accounts number
--         ]],
--         nargs = "?",
--     }
-- )



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
