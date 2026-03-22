if not vim.g.neovide then return end

vim.notify("gui config loaded")
vim.keymap.set("n", "<C-S-CR>", function()
    -- :vsplit | wincmd L | terminal<r>
    vim.cmd("vsplit | wincmd L | terminal")
    vim.cmd("startinsert")
end, { desc = "kitty-like open terminal in neovide" })
