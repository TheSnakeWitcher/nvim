local icons = require("util.icons")

---@help {diagnostic.txt}
vim.diagnostic.config({
    virtual_text = {
         current_line = true,
         severity = {
             min = vim.diagnostic.severity.INFO,
             max = vim.diagnostic.severity.WARN,
         }
    },

    virtual_lines = {
         current_line = true,
         severity = { min = vim.diagnostic.severity.ERROR }
     },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.DiagnosticError,
            [vim.diagnostic.severity.WARN] = icons.DiagnosticWarn,
            [vim.diagnostic.severity.INFO] = icons.DiagnosticInfo,
            [vim.diagnostic.severity.HINT] = icons.DiagnosticHint,
        },
    }
})
