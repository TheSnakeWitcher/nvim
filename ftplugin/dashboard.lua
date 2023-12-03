local ibl = require("ibl")
local bufnr = vim.api.nvim_get_current_buf()

ibl.setup_buffer(bufnr, {enabled = false})
