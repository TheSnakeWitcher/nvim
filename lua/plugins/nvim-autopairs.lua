local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
    vim.notify("nvim-autopairs config not loaded")
    return
end

autopairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
    },
    disable_filetype = { "TelescopePrompt", "guihua" }, -- disable autopairs for filetypes
    disable_in_macro = true,
    fast_wrap = {
        map = "<A-w>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
    },
})

-- cmp integration
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ok, cmp = pcall(require, "cmp")
if not ok then
    vim.notify("cmp not loaded in autopairs config")
    return
end

cmp.event:on({
    "confirm_done",
    cmp_autopairs.on_confirm_done(),
})
