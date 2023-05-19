local status_ok, peek = pcall(require,"peek")
if not status_ok then
    return
end

vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
vim.api.nvim_create_user_command('PeekClose', peek.close, {})

--vim.api.nvim_create_user_command('PeekOpen', function()
--  if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
--    vim.fn.system('i3-msg split horizontal')
--    peek.open()
--  end
--end, {})
--
--vim.api.nvim_create_user_command('PeekClose', function()
--  if peek.is_open() then
--    peek.close()
--    vim.fn.system('i3-msg move left')
--  end
--end, {})
