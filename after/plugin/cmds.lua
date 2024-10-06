--- @help {lua-guide-commands}
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

vim.api.nvim_create_user_command(
    "SwapClean",
    function(opts)
        vim.fn.jobstart(
            string.format("rm %s",vim.fn.stdpath("state") .. "/swap/*"),
            { on_exit = function() vim.notify("swap cleaned") end }
        )
    end,
    { desc = "clean swap files" }
)
