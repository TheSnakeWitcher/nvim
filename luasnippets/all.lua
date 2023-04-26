local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require "luasnip.extras"
local fmt = require("luasnip.extras.fmt").fmt
local events = require "luasnip.util.events"
local conds = require "luasnip.extras.conditions"
local ai = require "luasnip.nodes.absolute_indexer"
local m = extras.match
local l = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

ls.config.setup {
    enable_autosnippets = true,
    history = true,
    updateevents = "TextChanged,TextChangedI"
}

ls.env_namespace("USER", {
    vars = {
        VAR_NAME = "VAR_VALUE", --available as USER_VAR_NAME
    },
})

ls.add_snippets("all", {

    s(
        {
            name = "testsnippet",
            trig = "fuck",
            dscr = "",
            -- snippetType = "autosnippet",
        },
        fmt([[
	    fuck {}

	    {}
    ]]   ,
            {
                i(1, "name"),
                f(function(args, parent, user_args)
                    if args[1][1] == "test" then
                        return {
                            args[1][1]:upper() .. " tested",
                            args[1][1]:lower() .. parent.env.TM_LINE_NUMBER .. user_args,
                        }
                    end
                    return args[1][1] .. "extended"
                end, { 1 }, { user_args = { "user_arg" } }),
            }
        ),
        {
            -- condition = function(line_to_cursor, matched_trigger, captures)
            --   if line_to_cursor:match "^before cond" then
            --     return true
            --   else
            --     return false
            --   end
            -- end,
            show_condition = function(line_to_cursor)
                if line_to_cursor:match "^before " then
                    return true
                else
                    return false
                end
            end,
        }
    )

})
