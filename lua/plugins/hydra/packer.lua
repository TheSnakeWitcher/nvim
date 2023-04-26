local ok, Hydra = pcall(require,"hydra")
if not ok then
    vim.notify("hydra module not loaded in plugin hydra")
    return
end

local ok, packer = pcall(require,"packer")
if not ok then
    vim.notify("packer module not loaded in plugin hydra")
    return
end


local hint = [[
    _i_: plugins install    
    _u_: plugins update    
    _c_: plugins compile    
    _s_: plugins sync    
    _S_: plugins status    
    _q_: quit    
]]

Hydra({

   name = 'Plugins',
   hint = hint,
   config = {
      buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.cmd 'mkview'
         vim.cmd 'silent! %foldopen!'
         vim.bo.modifiable = false
      end,
      on_exit = function()
         local cursor_pos = vim.api.nvim_win_get_cursor(0)
         vim.cmd 'loadview'
         vim.api.nvim_win_set_cursor(0, cursor_pos)
         vim.cmd 'normal zv'
      end,
   },
   mode ='n',
   body = '<leader>P',
   heads = {
    {
        'i', function() packer.install() end,
        { expr = true, desc = 'install plugin' }
    },
    {
        'u',function() packer.update() end,
         { expr = true, desc = 'update plugin' }
    },
    {
         'c', function() packer.compile() end,
         { expr = true, desc = 'compile plugin' }
    },
    {
        's',function() vim.schedule(
                packer.sync()
        ) end,
        { expr = true, desc = 'sync plugins' }
    },
    {
        'S',function() vim.schedule(
                packer.status()
            ) end,
        { expr = true, desc = 'plugins status' }
    },

    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },

   }

})
