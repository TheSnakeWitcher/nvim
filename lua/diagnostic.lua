local icons = require("util.icons")

---@help {diagnostic.txt}
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.DiagnosticError,
            [vim.diagnostic.severity.WARN] = icons.DiagnosticWarn,
            [vim.diagnostic.severity.INFO] = icons.DiagnosticInfo,
            [vim.diagnostic.severity.HINT] = icons.DiagnosticHint,
        },
    }
})

---@help {signs}
vim.fn.sign_define("DapBreakpoint", { text = icons.DapBreakpoint, texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.DapBreakpointCondition, texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.DapBreakpointRejected, texthl = "DapBreakpointRejected" })
