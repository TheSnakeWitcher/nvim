vim.api.nvim_create_user_command("WebEnableAucmd", function()
    vim.api.nvim_get_autocmds({
        group = "Web3",
        event = "BufWritePost" ,
        pattern = "*.sol"
    })
    --vim.api.nvim_clear_autocmds
end, {})
