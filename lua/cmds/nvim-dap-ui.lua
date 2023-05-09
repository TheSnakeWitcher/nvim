local ok ,dapui = pcall(require,"dapui")
if not ok then
    return
end

vim.api.nvim_create_user_command("DapUI",dapui.toggle,{})
