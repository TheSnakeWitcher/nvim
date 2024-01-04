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
local n = extras.nonempty
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("lua", {

    --------------------------
    -- codebase structure
    --------------------------
    s({
        name = "base lua module",
        trig = "!",
        desc = "create a standard lua module structure",
    }, fmt([[
        local M = {{}}

        {}

        return M
    ]], {
        i(1, "module")
    })),

    s({
        name = "require",
        trig = "require",
        desc = "module requirement",
    }, fmt([[
        {}{} = require("{}")
    ]], {
        c(1, {
            t("local "),
            t(""),
        }),
        d(3,function(args)
            local module_path = vim.split(args[1][1], '.', true)
            return sn(
                nil,
                i(1, module_path[#module_path] or "")
            )
        end,{2},{}),
        i(2, "module")
    })),

    s({
        name = "return",
        trig = "return",
        desc = "return statement",
    }, fmt([[
        return {}
    ]], {
        i(1)
    })),

    s({
        name = "function",
        trig = "fn",
        desc = "function declaration",
    }, fmt([[
        {}function {}({})
            {}
        end
    ]], {
        c(1, {
            t("local "),
            t("")
        }),
        c(2, {
            i(1, "name"),
            t("")
        }),
        c(3, {
            i(1, "args"),
            t("")
        }),
        i(4, "-- code --")
    })),

    --------------------------
    -- control structure
    --------------------------
    s({
        name = "if",
        trig = "if",
        desc = "if statement declaration",
    },fmt([[
        if ({}) then
            {}
        end
    ]], {
        i(1, "cond"),
        i(2, "code"),
    })),

    s({
        name = "if",
        trig = "ife",
        desc = "if/else statement declaration",
    },fmt([[
        if ({}) then
            {}
        else
            {}
        end
    ]], {
        i(1, "cond"),
        i(2, "code"),
        i(3, "code"),
    })),

    s({
        name = "for",
        trig = "forr",
        desc = "for statement declaration",
    },fmt([[
        for {} = {} , {}{} do
            {}
        end
    ]], {
        i(1, "var"),
        i(2, "start"),
        i(3, "end"),
        c(4, {
            sn(nil, {
                t(" , "),
                i(1, "step"),
            }),
            t(""),
        }),
        i(5, "-- code --"),
    })),

    s({
        name = "while",
        trig = "while",
        desc = "execute code while condition is true",
    },fmt([[
        while {} do
            {}
        end
    ]], {
        i(1, "condition"),
        i(2, "-- code --"),
    })),

    s({
        name = "repeat until",
        trig = "repeat",
        desc = "repeat code until condition became true",
    }, fmt([[
        repeat
            {}
        until {}
    ]], {
        i(2, "-- code --"),
        i(1, "condition"),
    })),

    --------------------------
    -- data structure
    --------------------------
    s({
        name = "types",
        trig = "types",
        desc = "types",
    },fmt([[
        {}
    ]], {
        c(1, {
            t("string"),
            t("number"),
            t("boolean"),
            t("nil"),
        }),
    })),

    s({
        name = "local",
        trig = "local",
        desc = "variable declaration statement declaration",
    }, fmt([[
        local {} = {}
    ]], {
        i(1, "var"),
        i(2, "value"),
    })),

    --------------------------
    -- luasnip
    --------------------------
    s({
        name = "snippet",
        trig = "snippet",
        desc = "luasnip snippet declaration",
    }, fmt([[
      s(
        {{
            name = "{}",
            trig = "{}",
            desc = "{}",
        }},
        fmt([[
            {}
        ] ],{{
            {}
        }}),
      ),
    ]], {
        i(1, "name"),
        i(2, "trig"),
        i(3, "desc"),
        i(4, "code"),
        i(5, "nodes"),
    })),

})
