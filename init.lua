local ok , impatient = pcall(require,'impatient')
if not ok then
    vim.api.nvim_err_writeln("failed to load module impatient\n\n")
end
impatient.enable_profile()

for _, module in ipairs {
    "util",
    "options",
    "variables",
    "colorscheme",
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
