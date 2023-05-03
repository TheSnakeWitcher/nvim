vim.api.nvim_buf_set_keymap(
    vim.api.nvim_get_current_buf(),
    "i","[[","<esc><cmd>Telekasten insert_link<cr>",
    {desc = "insert link"}
)
