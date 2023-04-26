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

ls.add_snippets("julia", {

    --------------------------
    -- codebase structure
    --------------------------
    s({
        name = "import",
        trig = "import",
        dscr = "import statement",
    }, fmt([[
              import {}
            ]], {
        i(1, "pkg:obj as alias"),
    })
    ),

    s({
        name = "using",
        trig = "using",
        dscr = "using statement",
    }, fmt([[
              using {}
            ]], {
        i(1, "pkg:obj as alias"),
    })
    ),

    s({
        name = "include",
        trig = "include",
        dscr = "include statement",
    }, fmt([[
      using {}
    ]], {
        i(1, "pkg"),
    })
    ),

    s({
        name = "module",
        trig = "module",
        dscr = [[module declaration,note:
          baremodule: modules that don't contain base module
        ]],
    }, fmt([[
      {} {{
          {}
      }}
    ]], {
        c(1, {
            t("module"),
            t("baremodule"),
        }),
        i(1, "#= code =#"),
    }), {
        key = "baremodule"
    }),

    s({
        name = "function",
        trig = "fn",
        dscr = "function declaration",
    }, fmt([[
      function {}({}) {{
          {}
      }}
    ]], {
        c(1, {
            i(1, "name"),
            t(""),
        }),
        i(2, "arg::Type"),
        i(3, "#= code =#"),
    })
    ),

    s({
        name = "function-lambda",
        trig = "fnl",
        dscr = "function declaration",
    }, fmt([[
      ({}) -> {} 
    ]], {
        i(1, "arg::Type"),
        i(2, "#= code =#"),
    })
    ),

    --------------------------
    -- control structure
    --------------------------
    -- bifurcation/branch
    s({
        name = "if",
        trig = "if",
        dscr = "if statement declaration,note: if in julia don't declare a new scope",
    }, fmt([[
      if {} 
        {}
      end
    ]], {
        i(1, "cond"),
        i(2, "#= code =#")
    })
    ),

    s({
        name = "ife",
        trig = "ife",
        dscr = "if/else statement declaration,note: if in julia don't declare a new scope",
    }, fmt([[
      if {} 
        {}
      else
          {}
      end
    ]], {
        i(1, "cond"),
        i(2, "#= code =#"),
        i(3, "#= code =#"),
    })
    ),

    s({
        name = "ifi",
        trig = "ifi",
        dscr = "if in statement declaration,note: if in julia don't declare a new scope",
    }, fmt([[
      if {} in {} 
          {}
      end
    ]], {
        i(1, "item"),
        i(2, "container"),
        i(3, "#= code =#"),
    })
    ),

    s({
        name = "if-ternary",
        trig = "ift",
        dscr = "if statement declaration,note: if in julia don't declare a new scope",
    }, fmt([[
        {}
    ]], {
        c(1, {
            sn(nil, fmt([[
              {} ? {} : {}
            ]], {
                i(1, "cond"),
                i(2, "val_if_true"),
                i(3, "val_if_false"),
            })),
            sn(nil, fmt([[
                if {} {} else {} end
            ]], {
                i(1, "cond"),
                i(2, "val_if_true"),
                i(3, "val_if_false"),
            })),
        })
    })
    ),

    -- loops
    s({
        name = "while",
        trig = "while",
        dscr = "while statement",
    }, fmt([[
      while {}
        {}
      end
    ]], {
        i(1, "cond"),
        i(2, "#= code =#"),
    })
    ),

    s({
        name = "for-in",
        trig = "fori",
        dscr = "for statement",
    }, fmt([[
      for {} in {} 
        {}
      end
    ]], {
        i(1, "iter"),
        i(2, "container"),
        i(3, "#= code =#"),
    })
    ),

    s({
        name = "for-range",
        trig = "forr",
        dscr = "for statement",
    }, fmt([[
      for {} = {}
        {}
      end
    ]], {
        i(1, "iter"),
        i(2, "start:end"),
        i(3, "#= code =#"),
    })
    ),

    --------------------------
    -- data structure
    --------------------------
    s({
        name = "types",
        trig = "types",
        dscr = "types declaration",
    }, fmt([[
        {}
    ]], {
        c(1, {
            sn(nil, fmt([[
                Tuple([{}])
            ]], {
                i(1, "vals/label = vals"),
            })),
            sn(nil, fmt([[
                Dict({})
            ]], {
                i(1, "key => val")
            })),
        }),
    })
    ),

    s({
        name = "const",
        trig = "const",
        dscr = "const declaration",
    }, fmt([[
        const {}
    ]], {
        i(1, "arg::Type = val"),
    })
    ),

    s({
        name = "begin",
        trig = "begin",
        dscr = "don't declare a scope & return last expression by default",
    }, fmt([[
        begin
            {}
        end
    ]], {
        i(1, "arg = val"),
    })
    ),

    s({
        name = "let",
        trig = "let",
        dscr = "let declaration",
    }, fmt([[
        let {}
            {}
        end
    ]], {
        i(1, "arg = val"),
        i(2, "#= code =#"),
    })
    ),

    s({
        name = "struct",
        trig = "struct",
        dscr = "struct declaration",
    }, fmt([[
        {}struct {}
            {}
        end
    ]], {
        c(1, {
            t("mutable"),
            t(""),
        }),
        c(2, {
            i(1, "name"),
            sn(nil, fmt([[
                {} <: {}
            ]], {
                i(1, "name"),
                i(1, "base_type"),
            })),
        }),
        i(3, "field::Type"),
    })
    ),

    --------------------------
    -- auxiliar
    --------------------------

    s({
        name = "auxiliar functions",
        trig = "aux",
        dscr = [[usefull auxiliar function,note:
            typeof: return type of arg
            legth: get container legth
            size: get container dimensions
            is: determine if val1 is equal to val2
            isa: assert that var has type asserted_type
            convert: convert var to output_type
            super: return parent type of input_type
            subtypes: return subtypes types of input_type
            fieldnames: get fieldnames of var
        ]],
    }, fmt([[
        {}
    ]], {
        c(1, {
            t("varinfo()"),
            sn(nil, fmt([[
                typeof({})
            ]], {
                i(1, "var")

            })),
            sn(nil, fmt([[
                legth({})
            ]], {
                i(1, "container")

            })),
            sn(nil, fmt([[
                size({})
            ]], {
                i(1, "container")

            })),
            sn(nil, fmt([[
                is({},{})
            ]], {
                i(1, "var"),
                i(2, "asserted_type"),
            })),
            sn(nil, fmt([[
                isa({},{})
            ]], {
                i(1, "var"),
                i(2, "asserted_type"),
            })),
            sn(nil, fmt([[
                convert({},{})
            ]], {
                i(1, "output_type"),
                i(2, "var"),
            })),
            sn(nil, fmt([[
                super({})
            ]], {
                i(1, "input_type"),
            })),
            sn(nil, fmt([[
                subtypes({})
            ]], {
                i(1, "input_type"),
            })),
            sn(nil, fmt([[
                fieldnames({})
            ]], {
                i(1, "var"),
            })),
            sn(nil, fmt([[
                ismatch({},{})
            ]], {
                i(1, "pattern"),
                i(1, "string"),
            })),
        }),
    })
    ),

})
