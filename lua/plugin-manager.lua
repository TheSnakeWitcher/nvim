-- TODO: move cmds/autocmds to after/
-- TODO: enable spell in specific filetypes and comments
-- TODO: search where is seted <leader>D definition keymap and remove it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


--- @PluginList https://github.com/yutkat/my-neovim-pluginlist
--- @PluginList https://github.com/rockerBOO/awesome-neovim.git
require("lazy").setup("plugins")
