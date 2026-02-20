local ok , ls = pcall(require,"luasnip")
if not ok then
    vim.notify("luasnip config submodules not loaded")
    return
end

--- @help {luasnip-config-options}
ls.config.set_config({

    enable_autosnippets = true ,
    update_events = "TextChanged,TextChangedI",

    --- @help {luasnip-ext_opts}
    ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
          },
        },
    },
})

--- @help {luasnip-loaders}
require("luasnip.loaders.from_lua").lazy_load({ path = vim.g.path.snippets })
ls.filetype_extend("typescriptreact", { "typescript" })

vim.api.nvim_create_user_command(
    "LuaSnipEdit",
    require("luasnip.loaders").edit_snippet_files,
    {desc = "edit filetype snippets"}
)

vim.keymap.set({"i"}, "<C-Y>", function() ls.expand() end, {silent = true})

-- vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-n>", function()
	if ls.choice_active() then ls.change_choice(1) end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-p>", function()
	if ls.choice_active() then ls.change_choice(-1) end
end, {silent = true})

vim.keymap.set({"i","s"},"<C-s>",function()
    if ls.choice_active() then
        require('luasnip.extras.select_choice')()
    end
end,{desc = "select choice" , silent = true})
