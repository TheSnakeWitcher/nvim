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

ls.add_snippets("javascript", {

  ------------------------------------------------------
  --     				codebase structures   			--
  ------------------------------------------------------
  s({
    name = "import",
    trig = "im",
    dscr = "import code"
  },
    fmt([[
            import "{}" ;
        ]], {
      i(1, "pkg"),
    })
  ),

  s({
    name = "imports",
    trig = "ims",
    dscr = "import from code"
  },
    fmt([[
            import {{ {} }} from "{}" ;
        ]], {
      i(1, "obj"),
      i(2, "pkg"),
    })
  ),

  s({
    name = "export",
    trig = "exp",
    dscr = "export component from module pkg"
  },
    fmt([[
    	    export {}{} ;
        ]], {
      c(1,{
          t("default "),
          t(""),
      }),
      i(2, "component"),
    })
  ),

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
        i(1, "arg"),
        t(""),
      }),
      i(4, "/* code */"),
    })
  ),

s({
    name = "function-component",
    trig = "fnc",
    dscr = "react component declaration"
},
    fmt([[
        import "./{1}.css" ;

        function {2}({3}) {{
            return (
                {4}
            ) ;
        }}

        export default {5} ;
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
        rep(1),
    })
),


s({
    name = "function-async",
    trig = "fna",
    dscr = "function async declaration"
},
    fmt([[
        async function {1}({2}) {{
            {3}
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
        i(3, "/* code */"),
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
  --
  -- s({
  --   name="function",
  --   trig= "fnm",
  --   dscr= "method declaration"
  -- },
  --   fmt([[
  -- 	{1}function {2}({3}) {{
  -- 	  {4}
  -- 	}}
  --   ]],{
  --   	c(1,{
  --   	  t("public "),
  --   	  t(""),
  --   	  t("static "),
  --   	  t("public static "),
  --   	}),
  --   	i(2,"name"),
  --   	c(3,{
  --   	  i(1,"arg:type"),
  --   	  t(""),
  --   	}),
  --   	i(4,"/* code */"),
  --   })
  -- ),

  ------------------------------------------------------
  --     				control structures   			--
  ------------------------------------------------------
  --  bifurcation
  s({
    name = "if-ternary",
    trig = "ift",
    dscr = "if ternary statement"
  },
    fmt([[
      	{1} ? {2} : {3}
      ]], {
      i(1, "cond"),
      i(2, "val_if_true"),
      i(3, "val_if_false"),
    })
  ),

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
    name = "foreach",
    trig = "foreach",
    dscr = "calls function for every element of container"
  },
    fmt([[
      	{1}.forEach( {2} => {{
    	  {3}
      	}})
      ]], {
      i(1, "containerName"),
      i(2, "item"),
      i(3, "/* code */"),
    })
  ),

  s({
    name = "for",
    trig = "for",
    dscr = "for declaration"
  },
    fmt([[
      	for (let {1} = 0 , {2} ; {3} ) {{
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


  ------------------------------------------------------
  --     				   auxiliar     			    --
  ------------------------------------------------------
  s({
    name = "filter",
    trig = "filter",
    dscr = "filter function"
  },
    fmt([[
      	{1}.filter( {2} => {{
    	  {3}
      	}})
      ]], {
      i(1, "containerName"),
      i(2, "item"),
      i(3, "/* code */"),
    })
  ),

  s({
    name = "map",
    trig = "map",
    dscr = "map function"
  },
    fmt([[
      	{1}.map( {2} => {{
    	  {3}
      	}})
      ]], {
      i(1, "containerName"),
      i(2, "item"),
      i(3, "/* code */"),
    })
  ),

  s({
    name = "find",
    trig = "find",
    dscr = "find function"
  },
    fmt([[
      	{1}.find( {2} => {{
    	  {3}
      	}})
      ]], {
      i(1, "containerName"),
      i(2, "item"),
      i(3, "/* code */"),
    })
  ),

  s({
    name = "fetch",
    trig = "fetch",
    dscr = "fetch function"
  },
    fmt([[
      	let data = await fetch({{
      	    url: "{}",
      	    method: "{}",
      	    {}
      	}})
      ]], {
      i(1, "url"),
      c(2,{
         t("GET"),
         t("POST"),
         t("PUT"),
         t("DELETE"),
      }),
      c(3,{
        sn(nil,fmt([[
            body: {}
        ]],{
            i(1,"data")
        })),
        t(""),
      }),
    })
  ),

  s({
    name = "hooks",
    trig = "hooks",
    dscr = "hooks"
  },
    fmt([[
      	useState
      	useEffect
      ]], {})
  ),

  s({
    name = "useState",
    trig = "useState",
    dscr = "declare a component state variable"
  },
    fmt([[
        const [{},{}] = useState({})
    ]], {
        i(1,"variable"),
        f(function(nodes)
            local str = nodes[1][1]
            local first_char = string.sub(str,0,1)
            local rest = string.sub(str,2,#str)
            return "set" .. string.upper(first_char) .. rest
        end,{1},{}),
        i(2,"defaultValue"),
    })
  ),

})
