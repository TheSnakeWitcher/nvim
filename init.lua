for _, module in ipairs({
    "util",
    "variables",   --- @help {lua-vim-variables}
    "options",     --- @help {options}
    "plugins",
    "keymap",      --- @help {lua-keymap}
    "diagnostic",  --- @help {diagnostic.txt}
}) do
    local ok, _ = pcall(require, module)
    if not ok then
        vim.notify("failed to load module " .. module)
    end
end
