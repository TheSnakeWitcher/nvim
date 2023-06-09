local status_ok, nvim_foldsign = pcall(require,"nvim-foldsign")
if not status_ok then
    vim.notify "nvim foldsign config not loaded"
    return
end

nvim_foldsign.setup({
    offset = -2,
    foldsigns = {
        --open = "",
        --close = "",
        open = '+',          -- mark the beginning of a fold
        close = '-',         -- show a closed fold
        seps = { '│', '┃' }, -- open fold middle marker
    }
})
