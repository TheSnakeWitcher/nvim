local overseer = require("overseer")

vim.api.nvim_create_user_command("OverseerRestartLast", function()

    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("no tasks found", vim.log.levels.warn)
    else
        overseer.run_action(tasks[1], "restart")
    end

end, {
    desc = "restart last task",
})


vim.api.nvim_create_user_command(
    "Make",
    function(params)
        local args = vim.fn.expandcmd(params.args)
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)  -- insert args at the '$*' in the makeprg

        if num_subs == 0 then
            cmd = cmd .. " " .. args
        end

        overseer.new_task({
            cmd = cmd,
            components = {
                { "on_output_quickfix", open = not params.bang, open_height = 8 },
                "default",
            },
        }):start()
    end,
    {
        desc = "run your makeprg as an overseer task",
        nargs = "*",
        bang = true,
    }
)
