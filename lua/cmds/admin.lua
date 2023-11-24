vim.api.nvim_create_user_command(
    "SwapClean",
    function(opts)
        vim.fn.jobstart(
            string.format("rm %s",vim.fn.stdpath("state") .. "/swap/*"),
            { on_exit = function() vim.notify("swap cleaned") end }
        )
    end,
    {}
)
