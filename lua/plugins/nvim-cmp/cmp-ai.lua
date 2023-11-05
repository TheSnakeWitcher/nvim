local ok, cmp_ai = pcall(require,"cmp_ai.config")
if not ok then
    vim.notify "cmp-ai config not loaded"
    return
end


--- @doc {cmp-git-config}
cmp_ai:setup({
    max_lines = 1000,
    provider = 'HF',
    notify = true,
    notify_callback = function(msg)
        vim.notify(msg)
    end,
    run_on_every_keystroke = true,
    ignored_file_types = {},
})
