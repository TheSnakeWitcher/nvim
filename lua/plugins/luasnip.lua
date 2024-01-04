local ok , ls = pcall(require,"luasnip")
if not ok then
    vim.notify("luasnip config submodules not loaded")
    return
end

local types = require("luasnip.util.types")
local lua_loader = require("luasnip.loaders.from_lua") --- @help {luasnip-loaders}


--- @help {luasnip-config-options}
ls.config.set_config({

    enable_autosnippets = true ,
    update_events = "TextChanged,TextChangedI",

    --- @help {luasnip-ext_opts}
    ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
          },
        },
    },
})

lua_loader.lazy_load({path = vim.g.path.snippets })
ls.filetype_extend("typescriptreact", { "typescript" })
