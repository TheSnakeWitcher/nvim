local cmp = require("cmp")

--- @help {cmp.setup.filetype}
cmp.setup.filetype({'markdown'}, {
    sources = cmp.config.sources({
        { name = 'otter' },
    })
})
