-- vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
-- vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
-- vim.fn.sign_define("DiagnosticSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
-- vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
-- vim.fn.sign_define("DiagnosticSignHint", {text = "💡", texthl = "DiagnosticSignHint"})


vim.diagnostic.config({
    virtual_text = true, -- default true,disable is using lsp_lines plugin because will be redundant
--     signs = true,
--    signs = {
--      active = {
--		    { name = "DiagnosticSignError", text = "" },
--		    { name = "DiagnosticSignWarn", text = "" },
--		    { name = "DiagnosticSignHint", text = "" },
--		    { name = "DiagnosticSignInfo", text = "" },
--      }
--    },
--    update_in_insert = true, -- default false
--    underline = true,
--    severity_sort = false,
--    --float = true,
--    float = {
--        focusable = true,
--        style = "minimal",
--        border = "rounded",
--        source = "always",
--        header = "",
--        prefix = "",
--    },
})
