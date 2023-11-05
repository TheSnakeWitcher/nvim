local ok, comment = pcall(require,"Comment")
if not ok then
    vim.notify "comment config not loaded"
    return
end


local ok, comment_nvim = pcall(require,"ts_context_commentstring.integrations.comment_nvim")
if not ok then
    vim.notify "ts contenxt commentstring integration not loaded in Comment"
end


--- @doc {comment.config}
comment.setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
    },
    pre_hook = comment_nvim.create_pre_hook() or nil,
    post_hook = nil,
})
