local ok, hydra = pcall(require,"hydra")
if not ok then
    vim.notify("hydra config not loaded")
    return
end

--hydra.setup({ })
--

--hydra({
--   name = 'side scroll',
--   mode = 'n',
--   config = {
--      
--   }
--   body = 'z',
--   heads = {
--      { 'h', '5zh' },
--      { 'l', '5zl', { desc = '←/→' } },
--      { 'H', 'zH' },
--      { 'L', 'zL', { desc = 'half screen ←/→' } },
--   }
--})


--hydra({
--   name = 'side scroll',
--   mode = 'n',
--   config = {
--      desc
--      exit = 
--      foreign_keys
--      buffer
--      on_enter
--      on_exit
--      invoke_on_body
--   }
--   body = 'z',
--   heads = {
--      { 'h', '5zh' },
--      { 'l', '5zl', { desc = '←/→' } },
--      { 'H', 'zH' },
--      { 'L', 'zL', { desc = 'half screen ←/→' } },
--   }
--})


local ok, _ = pcall(require,"plugins.hydra.git")
if not ok then
    vim.notify("git hydra not loaded")
    return
end

--local ok, _ = pcall(require,"plugins.hydra.packer")
--if not ok then
--    vim.notify("plugin manager hydra not loaded")
--    return
--end
