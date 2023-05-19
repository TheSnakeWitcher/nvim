local ok,chisel = pcall(require,"chisel")
if not ok then return end

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
