local status_ok , ls = pcall(require,"luasnip")
if not status_ok then
    vim.notify("luasnip config submodules not loaded")
    return
end


local status_ok , types = pcall(require, "luasnip.util.types")
if not status_ok then
    vim.notify("luasnip.util.types config submodule not loaded")
    return
end


require("luasnip.loaders.from_lua").lazy_load({
    path = vim.g.snippets_dir
    -- path = vim.g.path.snippets
})


ls.filetype_extend("typescriptreact", { "typescript" })


--- @help {luasnip-config-options}
ls.config.set_config({
    history = true,
    enable_autosnippets = true ,
    update_events = "TextChanged,TextChangedI",
    --delete_check_events = 'InsertLeave',
    --ft_func = require('luasnip.extras.filetype_functions').from_cursor,
    ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
          },
        },
        --[types.insertNode] = {
        --  active = {
        --    virt_text = { { '', 'DiagnosticWarn' } },
        --  },
        --},
    },
})
