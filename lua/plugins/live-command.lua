local ok, live_command = pcall(require,"live-command")
if not ok then
    vim.notify "live-command config not loaded"
    return
end


--- @help {live-command.nvim-example}
live_command.setup({
    commands = {
        Norm = { cmd = "norm" },
    },
})
