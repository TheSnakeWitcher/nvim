for _, module in ipairs({
    "util",
    "variables",   --- @help {lua-vim-variables}
    "options",     --- @help {options}
    "plugins",
    "keymap",      --- @help {lua-keymap}
    "autocmds",    --- @help {lua-guide-autocommands}
    "cmds",        --- @help {lua-guide-commands}
    "diagnostics", --- @help {diagnostic.txt}
    "signs",       --- @help {sign.txt}
    "highlight",
}) do
  local ok, _ = pcall(require, module)
  if not ok then
        vim.notify("failed to load module " .. module)
    end
end
