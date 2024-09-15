vim.api.nvim_create_user_command(
    "DAPUI",
    'lua require("dapui").toggle()<cr>',
    { desc = "toggle DAP UI" }
)

vim.api.nvim_create_user_command(
    "GHDash",
    'lua require("toggleterm.terminal").Terminal:new({ cmd = "gh dash", direction = "float" }):toggle()<cr>',
    { desc = "open gh dash" }
)
