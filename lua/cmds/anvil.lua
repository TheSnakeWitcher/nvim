local ok,anvil = pcall(require,"anvil")
if not ok then return end

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
