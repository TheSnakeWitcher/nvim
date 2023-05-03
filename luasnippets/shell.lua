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

ls.add_snippets("sh", {

    --------------------------
    -- codebase structure
    --------------------------
    s({
        name = "if",
        trig = "if",
        dscr = "if statement declaration",
    }, fmt([[
        if {} ; then
          {}
        fi
    ]], {
        i(1, "-d dir/-f file/-z exist/cond"),
        i(2, "code"),
    })),

    s({
        name = "while",
        trig = "while",
        dscr = "while statement",
    }, fmt([[
            {}
        ]], {
        c(1, {
            sn(nil, fmt([[
            while {} ; do
              {}
            done
              ]], {
                i(1, "condition"),
                i(2, "code"),
            })),
            sn(nil, fmt([[
                while {} ; do {} ; done
            ]], {
                i(1, "condition"),
                i(2, "code"),
            })),
        })
    })),

    s({
        name = "for",
        trig = "for",
        dscr = "for statement",
    }, fmt([[
            for {} in {} ; do
                {}
            done
    ]], {
        i(1,"item"),
        i(2,"container"),
        i(3,"# code #"),
    })),

})
