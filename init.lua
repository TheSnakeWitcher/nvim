local ok , impatient = pcall(require,'impatient')
if not ok then
    vim.api.nvim_err_writeln("failed to load module impatient\n\n")
end
impatient.enable_profile()

for _, module in ipairs {
    "util",
    "options",
    "colorscheme",
    "variables",
    "keymap",
    "diagnostic",
    "plugins",
    "autocmds",
    "cmds",
    "highlight",
} do
  local ok, _ = pcall(require, module)
  if not ok then
        vim.api.nvim_err_writeln("failed to load module " .. module .. "\n\n")
    end
end
