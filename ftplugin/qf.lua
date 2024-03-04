--- @help https://github.com/folke/trouble.nvim/issues/70

function ToggleTroubleAuto()
    local ok, trouble = pcall(require, "trouble")
    if ok then
        vim.defer_fn(function()
            vim.cmd('cclose')
            trouble.open('quickfix')
        end, 0)
    end
end

vim.cmd("autocmd BufWinEnter quickfix silent :lua ToggleTroubleAuto()")
