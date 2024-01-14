local icons = require("util.icons")


---@help {diagnostic}
vim.fn.sign_define("DiagnosticSignError", { text = icons.DiagnosticError, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = icons.DiagnosticWarn, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icons.DiagnosticInfo, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = icons.DiagnosticHint, texthl = "DiagnosticSignHint" })

---@help {signs}
vim.fn.sign_define("DapBreakpoint", { text = icons.DapBreakpoint, texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.DapBreakpointCondition, texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.DapBreakpointRejected, texthl = "DapBreakpointRejected" })
