local cmp = require("cmp")

cmp.setup.filetype('plaintex', {
    sources = cmp.config.sources({
        {
            name = "latex_symbols",
            option = { strategy = 2 }, --- @help{cmp-latex-symbols-options}
        },
    })
})
