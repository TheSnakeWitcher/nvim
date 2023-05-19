local ok, luasnip_loaders = pcall(require,"luasnip.loaders")
if not ok then
    return
end

-- command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()
vim.api.nvim_create_user_command(
    "LuaSnipEdit",
    luasnip_loaders.edit_snippet_files,
    {desc = "edit filetype snippets"}
)
