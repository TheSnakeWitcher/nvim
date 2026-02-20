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

ls.add_snippets("typescript", {

  ------------------------------------------------------
  --     				codebase structures   			--
  ------------------------------------------------------
  s({
    name = "function",
    trig = "fn",
    dscr = "function declaration"
  },
    fmt([[
        {1}function {2}({3}) {{
            {}
        }}
    ]], {
      c(1, {
        t(""),
        t("export "),
      }),
      c(2,{
          i(1, "name"),
          t(""),
      }),
      c(3, {
        i(1, "arg:type"),
        t(""),
      }),
      i(4, "/* code */"),
    })
  ),

s({
    name = "function-async",
    trig = "fna",
    dscr = "function async declaration"
},
    fmt([[
        async function {1}({2}) {3}{{
            {4}
        }}
    ]], {
      c(1,{
          i(1, "name"),
          t(""),
      }),
        c(2, {
            i(1,"args:type"),
            t(""),
        }),
        c(3, {
            sn(1,fmt(": {} ",{ i(1,"return") })),
            t(""),
        }),
        i(4, "/* code */"),
    })
),

  s({
    name="function-lambda",
    trig= "fl",
    dscr= "function lambda declaration"
  },
    fmt([[
    {1}const {2} = ({3}) => {{
  	  {4}
  	}}
    ]],{
    	c(1,{
    	  t("export "),
    	  t("")
    	}),
    	i(2,"name"),
    	c(3,{
    	  i(1,"arg:type"),
    	  t(""),
    	}),
    	i(4,"/* code */"),
    })
  ),

   s({
     name="function-method",
     trig= "fm",
     dscr= "method declaration"
   },
     fmt([[
   	{1}function {2}({3}) {{
   	  {4}
   	}}
     ]],{
     	c(1,{
     	  t(""),
     	  t("public "),
     	  t("static "),
     	}),
     	i(2,"name"),
     	c(3,{
     	  i(1,"arg:type"),
     	  t(""),
     	}),
     	i(4,"/* code */"),
     })
   ),


s({
        name = "function-component",
        trig = "fnc",
        dscr = "react component declaration"
    },
    fmt([[
        import "./{1}.css" ;

        export default function {2}({3}) {{
            return (
                {4}
            ) ;
        }}
    ]], {
        --f(function(nodes) return nodes[1][1] end ,{2},{}),
        rep(1),
        d(1, function()
            local file = vim.fn.expand("%:t")
            local extension = vim.fn.expand("%:t:e")
            local name = string.gsub(file, "." .. extension, "")

            return sn(nil, {
                    i(1, name),
            })
        end, {}, {}),
        c(2, {
            t(""),
            t("props"),
            sn(nil,{
                t("{"),
                i(1, "args"),
                t("}"),
            }),
        }),
        i(3, "/* code */"),
    })
),

  ------------------------------------------------------
  --     				control structures   			--
  ------------------------------------------------------
  --  bifurcation
  s({
    name = "if",
    trig = "if",
    dscr = "if statement"
  },
    fmt([[
      	if ({1}) {{
    	  {2}
      	}}
      ]], {
      i(1, "cond"),
      i(2, "/* code */"),
    })
  ),

  s({
    name = "if-else",
    trig = "ife",
    dscr = "if/else statement"
  },
    fmt([[
      	if ({1}) {{
    	  {2}
      	}} else {{
    	  {3}
      	}}
      ]], {
      i(1, "cond"),
      i(2, "/* code */"),
      i(3, "/* code */"),
    })
  ),

  s({
    name = "switch",
    trig = "switch",
    dscr = "switch statement"
  },
    fmt([[
      	switch ({1}) {{
      	case {2}:
      	  {4}
      	  break ;
      	case {3}:
      	  {5}
      	  break ;
      	default:
      	  {6}
      	}}
      ]], {
      i(1, "var|expression"),
      i(2, "cond1"),
      i(3, "cond2"),
      i(4, "/* code */"),
      i(5, "/* code */"),
      i(6, "/* code */"),
    })
  ),

  --  loops
  s({
    name = "loop",
    trig = "loop",
    dscr = "infinite loop"
  },
    fmt([[
      	while (true) {{
    	  {1}
      	}}
      ]], {
      i(1, "/* code */"),
    })
  ),

  s({
    name = "while",
    trig = "while",
    dscr = "while statement"
  },
    fmt([[
      	while ({1}) {{
    	  {2}
      	}}
      ]], {
      i(1, "cond"),
      i(2, "/* code */"),
    })
  ),

  s({
    name = "while",
    trig = "whiled",
    dscr = "while statement"
  },
    fmt([[
      	do {{
    	  {2}
      	}} while ({1})
      ]], {
      i(1, "cond"),
      i(2, "/* code */"),
    })
  ),

  s({
    name = "for",
    trig = "for",
    dscr = "for declaration"
  },
    fmt([[
      	for (let {1} = 0 ; {2} ; {3} ) {{
    	  {4}
      	}}
      ]], {
      i(1, "var"),
      i(2, "cond"),
      i(3, "change"),
      i(4, "/* code */"),
    })
  ),

  ------------------------------------------------------
  --     				 data structures    			--
  ------------------------------------------------------
  s({
    name = "type",
    trig = "type",
    dscr = "type alias declaration"
  },
    fmt([[
      	type {1} = {2} ;
      ]], {
      i(1, "name"),
      i(2, "types | types")
    })
  ),

  s({
    name = "types",
    trig = "types",
    dscr = "languaje types"
  },
    fmt([[
      	{}
      ]], {
      c(1, {
        t("string"),
        t("number"),
        t("bool"),
        t("void"),
        t("null"),
        t("undefined"),
        t("any"),
      })
    })
  ),

  s({
    name = "const",
    trig = "const",
    dscr = "const"
  },
    fmt([[
      	const {}
    ]], {
      c(1, {
        sn(nil, fmt([[
                    {} : {} = {}
                ]], {
          i(1, "name"),
          i(2, "type"),
          i(3, "value"),
        })),
        sn(nil, fmt([[
                    {1} : {2} = {{
                        {3}
                    }}
                ]], {
          i(1, "name"),
          i(2, "type"),
          i(3, "key:value"),
        })),
      })
    })
  ),

  s({
    name = "let",
    trig = "let",
    dscr = "let statement declaratoin"
  },
    fmt([[
      	let {}
    ]], {
      c(1, {
        sn(nil, fmt([[
                    {} : {} = {}
                ]], {
          i(1, "name"),
          i(2, "type"),
          i(3, "value"),
        })),
        sn(nil, fmt([[
                    {1} : {2} = {{
                        {3}
                    }}
                ]], {
          i(1, "name"),
          i(2, "type"),
          i(3, "key:value"),
        })),
      })
    })
  ),

  s({
    name = "enum",
    trig = "enum",
    dscr = "class declaration"
  },
    fmt([[
            {1}enum {2} {{
                {3}
            }}
        ]], {
      c(1, {
        t("const "),
        t("")
      }),
      i(2, "name"),
      i(3, "pattern = val ,"),
    })
  ),

  s({
    name = "class",
    trig = "class",
    dscr = "class declaration"
  },
    fmt([[
            class {1}{2}{{
                {3}

                {4}
            }}
        ]], {
      i(1, "name"),
      c(2, {
        sn(nil, {
          t(" extends "),
          i("parentClass"),
        }),
        t("")
      }),
      i(3, "field:type ;"),
      c(4, {
        sn(nil, fmt([[
    		constructor({1}) {{
    		  {2}
    		}}
      	  ]], {
          i(1, "args:type"),
          i(2, "this.arg"),
        })),
        i(1, "methods")
      }),
    })
  ),

  s({
    name = "interface",
    trig = "interface",
    dscr = "interface declaration"
  },
    fmt([[
      	    interface {1} {{
    	      {2} ;
      	    }}
        ]], {
      i(1, "name"),
      i(2, "field:type"),
    })
  ),

})
