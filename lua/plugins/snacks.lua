local ok, snacks = pcall(require, "snacks")
if not ok then
    vim.notify("snacks config not loaded")
    return
end

--- @help {snacks.nvim}
snacks.setup({
    bigfile = { enabled = true },                   -- improve nvim performance in big files
    image = { enabled = true },                     -- image previewer, alternatives: "3rd/image.nvim"
    notifier = { enabled = true, style = "fancy" }, -- improve notifications(vim.notify)
})

_G.dd = function(...)
    snacks.debug.inspect(...)
end
_G.bt = function()
    snacks.debug.backtrace()
end

vim.ui.input = snacks.input.input
vim.print = _G.dd
