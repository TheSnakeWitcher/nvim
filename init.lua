for _, module in ipairs {
    "util",
    "options",
    "variables",
    "diagnostic",
    "plugins",
    "keymap",
    "autocmds",
    "cmds",
    "highlight",
} do
  local ok, _ = pcall(require, module)
  if not ok then
        vim.notify("failed to load module " .. module)
    end
end
