local ok, snacks = pcall(require, "snacks")
if not ok then
    vim.notify("snacks config not loaded")
    return
end

--- @help {snacks.nvim}
snacks.setup({
    bigfile = { enabled = true },
    input = { enabled = true },
})

_G.dd = function(...)
    snacks.debug.inspect(...)
end
_G.bt = function()
    snacks.debug.backtrace()
end
vim.print = _G.dd
