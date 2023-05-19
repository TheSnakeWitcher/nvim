local ok,anvil = pcall(require,"anvil")
if not ok then return end

local anvil_augroup = vim.api.nvim_create_augroup("Anvil",{clear = false})

vim.api.nvim_create_autocmd("VimLeave",{
    group = anvil_augroup,
    desc = "avoid leave without stoping anvil",
    callback = function() anvil.stop() end,
})
