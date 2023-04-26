local status_ok, urlview = pcall(require,"urlview")
if not status_ok then
    vim.notify("urlview config not loaded")
    return
end


-- register custom action to execute
--urlview.actions["myaction"] = function(raw_url)
--  -- TODO
--end


urlview.setup({

  default_title = "Links:",            -- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
  default_picker = "telescope",        -- or native
  default_prefix = "https://",         -- default protocol to prefix URLs with if they don't start with http/https
  default_action = "system",           -- action to execute, options are "netrw","system","clipboard","firefox"
  unique = true,                       -- ensure links are unique (no duplicates)
  sorted = true,                       -- ensure links are sorted alphabetically
  log_level_min = vim.log.levels.INFO, -- min log level (recommended at least `vim.log.levels.WARN` for error detection warnings)
  -- keymaps for jumping to previous / next URL in buffer
  jump = {
    prev = "[u", -- consider [L
    next = "]u", -- consider ]L
  },

})
