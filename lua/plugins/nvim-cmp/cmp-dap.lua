local cmp = require("cmp")

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = cmp.config.sources({
        { name = "dap" },
    }),
})
