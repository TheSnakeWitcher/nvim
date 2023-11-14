---@doc {diagnostic}
vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})


---@doc {signs}
vim.fn.sign_define("DapBreakpoint", {text = "" })
vim.fn.sign_define("DapBreakpointCondition", {text = "" })
vim.fn.sign_define("DapBreakpointRejected", {text = "" })
