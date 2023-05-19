local M = {}

M.confirm = function(opts,yes_tbl,no_tbl)
    local yes_msg ,no_msg = "yes" , "no"

    vim.ui.select({yes_msg,no_msg},opts,function(choice)
        if choice == yes_msg then
            yes_tbl.fn(yes_tbl.args)
        end

        if no_tbl then
            no_tbl.fn(no_tbl.args)
        end
    end)
end

return M
