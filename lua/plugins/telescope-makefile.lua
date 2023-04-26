local status_ok, telescope_makefile = pcall(require,"telescope-makefile")
if not status_ok then
    vim.notify "telescope-makefile config not loaded"
    return
end


telescope_makefile.setup{
  -- The path where to search the makefile in the priority order
  makefile_priority = { '.', 'build/' },
  default_target = '[DEFAULT]', -- nil or string : Name of the default target | nil will disable the default_target
  make_bin = "make", -- Custom makefile binary path, uses system make by def
}
