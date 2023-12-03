local ok, treesj = pcall(require,"treesj")
if not ok then
    vim.notify "treesj config not loaded"
    return
end

---@help {treesj-treesj-settings|
treesj.setup({
      use_default_keymaps = true,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = 'hold',
      notify = true,
      dot_repeat = true,
      on_error = nil,
})
