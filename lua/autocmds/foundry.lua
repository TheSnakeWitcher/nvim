local ok,foundry = pcall(require,"foundry")
if not ok then return end


local anvil = foundry.anvil


local foundry_augroup = vim.api.nvim_create_augroup("Foundry",{clear = false})

vim.api.nvim_create_autocmd("VimLeave",{
    group = foundry_augroup,
    desc = "avoid leave without stoping anvil",
    callback = function() anvil.stop() end,
})
