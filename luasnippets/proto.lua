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


ls.add_snippets("proto", {

  ------------------------------------------------------
  -- 	              codebase structures   	 	--
  ------------------------------------------------------
  s(
    {
      name = "base structure",
      trig = "!",
      dscr = "basic proto file structure/layout",
      snippetType = "autosnippet",
    },
    fmt([[
      sintax = "{1}" ;

      package {2} ;

      {}
    ]],
      {
        i(1,  "proto3"),
        -- i(2, "name"),
        d(2, function()
            local filename = vim.fn.expand("%:t:r")
            return sn(nil,{
                i(1,filename)
            })
           end, {}, {}),
        i(3, "message/service"),
      }
    )
  ),

  s(
    {
      name = "import",
      trig = "imp",
      dscr = "import declaration",
    },
    fmt([[
      import "{1}" ;
    ]],
      {
        i(1, "name"),
      }
    )
  ),

  s(
    {
      name = "options",
      trig = "options",
      dscr = "options declaration",
    },
    fmt([[
      option {} = "{}" ;
    ]],
      {
        c(1, {
          t("go_package"),
          t("rust_package"),
        }),
        i(2, "option_value"),
      }
    )
  ),

  ------------------------------------------------------
  --     				data structures   				--
  ------------------------------------------------------
  s(
    {
      name = "types",
      trig = "types",
      dscr = "types declaration",
    },
    fmt([[
      {}
    ]],
      {
        c(1, {
          t "string",
          t "float",
          t "int32",
          t "map < key_type , val_type >",
          t "enum {{",
        }),
      }
    )
  ),

  s(
    {
      name = "map",
      trig = "map",
      dscr = "map declaration",
    },
    fmt([[
      map<{1},{2}> {3} = {4} ;
    ]],
      {
        i(1, "key_type"),
        i(2, "val_type"),
        i(3, "name"),
        i(4, "num"),
      }
    )
  ),

  s(
    {
      name = "message",
      trig = "message",
      dscr = "message declaration",
    },
    fmt([[
      message {1} {{
        {2}
      }}
    ]],
      {
        i(1, "name"),
        i(2, "constrant type fields = num ;"),
      }
    )
  ),

  s(
    {
      name = "enum",
      trig = "enum",
      dscr = "enum declaration",
    },
    fmt([[
      enum {1} {{
        {2}
      }}
    ]],
      {
        i(1, "name"),
        i(2, "name = number ;"),
      }
    )
  ),

  s(
    {
      name = "service",
      trig = "service",
      dscr = "service declaration",
    },
    fmt([[
      service {1} {{
        {2}
      }}
    ]],
      {
        i(1, "name"),
        i(2, "rpc"),
      }
    )
  ),

  s(
    {
      name = "rpc",
      trig = "rpc",
      dscr = "rpc declaration",
    },
    fmt([[
      rpc {1}({2}){3} ;
    ]],
      {
        i(1, "name"),
        c(2, {
          i(1, "[stream] args"),
          t "",
        }),
        c(3, {
          sn(nil, {
            t " returns (",
            i(1, "return_type"),
            t ")",
          }),
          t "",
        }),
      }
    )
  ),

})
