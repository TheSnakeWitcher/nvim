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
local n = extras.nonempty
local l = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")

-- common nodes
ls.add_snippets("zig", {

  ------------------------------------------------------
  --     				   codebase structures   			        --
  ------------------------------------------------------
  s(
    {
      name = "function",
      trig = "fn",
      dscr = "function declaration",
    },
    fmt([[
      {1}fn {2}({3}){4}{{
        {5}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        c(3, {
          i(1, "args"),
          t "",
        }),
        c(4, {
          sn(nil, {
            t " ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(5, "// code")
      }
    )
  ),

  s(
    {
      name = "method",
      trig = "fm",
      dscr = "method declaration",
    },
    fmt([[
      pub fn {1}(self: {2}){3}{{
        {4}
      }}
    ]],
      {
        i(1, "name"),
        i(2, "args"),
        -- f(function()
        --     end, {},{}),
        c(3, {
          sn(nil, {
            t " ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(4, "// code"),
      }
    )
  ),

  ------------------------------------------------------
  --     				control structures   			--
  ------------------------------------------------------
  -- bifurcations/branchs
  s(
    {
      name = "if-ternary",
      trig = "ift",
      dscr = "if/else inline statement",
    },
    fmt([[
    if ({1}) {2} else {3}
  ]] ,
      {
        i(1, "cond"),
        i(2, "val_if_true"),
        i(3, "val_if_false"),
      }
    )
  ),

  s(
    {
      name = "if",
      trig = "if",
      dscr = "if|if let statemnt",
    },
    fmt([[
    if {1} {{
      {2}
    }}
  ]] ,
      {
        c(1, {
          i(1, "cond"),
          sn(1, {
            t("let "),
            i(1, "pattern"),
            t(" = "),
            i(2, "var"),
          }),
        }),
        i(2, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-else",
      trig = "ife",
      dscr = "if/else statemnt",
    },
    fmt([[
    if {1} {{
      {2}
    }} else {{
      {3}
    }}
  ]] ,
      {
        c(1, {
          i(1, "cond"),
          sn(1, {
            t("let "),
            i(1, "pattern"),
            t(" = "),
            i(2, "var"),
          }),
        }),
        i(2, "/* code */"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "switch",
      trig = "switch",
      dscr = "switch statement",
    },
    fmt([[
    switch({1}) {{
      {2} => {4}
      {3} => {5}
      {6}
    }}
  ]] ,
      {
        i(1, "pattern"),
        c(2, {
          i(1, "pattern1"),
          c(2, {
            t "",
            sn(1, {
              t " if ",
              i(1, "cond"),
            }),
          }),
        }),
        c(3, {
          i(1, "pattern1"),
          c(2, {
            t "",
            sn(1, {
              t " if ",
              i(1, "cond"),
            }),
          }),
        }),
        i(4, "/* code1 */"),
        i(5, "/* code2 */"),
        c(6, {
          sn(1, {
            i(1, "_/other"),
            t " => ",
            i(2, "/* code_default */"),
          }),
          t "",
        }),
      }
    )
  ),

  -- loops
  s(
    {
      name = "while",
      trig = "while",
      dscr = "while|while let statement declaration",
    },
    fmt([[
    while {1} {{
      {2}
    }}
  ]] ,
      {
        c(1, {
          i(1, "cond"),
          sn(1, {
            t("let "),
            i(1, "pattern"),
            t(" = "),
            i(2, "var"),
          }),
        }),
        i(2, "/* code */"),
      }
    )
  ),
  s(
    {
      name = "for",
      trig = "for",
      dscr = "for statement",
    },
    fmt([[
    for ({1}) |{2}| {{
	  {3}
    }}
  ]] ,
      {
        i(1, "iterable"),
        i(2, "var"),
        i(3, "// code"),
      }
    )
  ),

  ------------------------------------------------------
  --     				data structures   				--
  ------------------------------------------------------
  s(
    {
      name = "const",
      trig = "const",
      dscr = [[ constant declaration, note:
      type must be provided and value is know at compiled time
      const dont allocate memory, they are substituted at compile time
    ]] ,
    },
    fmt([[
    const {1} : {2} = {3} ;
  ]] ,
      {
        i(1, "name"),
        i(2, "type"),
        i(3, "val"),
      }
    )
  ),

  s(
    {
      name = "struct",
      trig = "st",
      dscr = "struct declaration",
    },
    fmt([[
    {1}const {2} = struct {{
        {3}
    }};
  ]] ,
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        i(3, "// fields"),
      }
    )
  ),

  s(
    {
      name = "enum",
      trig = "enum",
      dscr = "enum declaration, note:the enum size is only the size of bigger element,could be field(field_data) or field{key:val}",
    },
    fmt([[
      {1}enum {2}  {{
        {3}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        i(3, "variant/variant(data)/variant{data}"),
      }
    )
  ),

})
