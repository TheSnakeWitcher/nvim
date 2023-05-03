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

-- common nodes

ls.add_snippets("rust", {

  ------------------------------------------------------
  --     				   codebase structures   			        --
  ------------------------------------------------------
  s(
    {
      name = "pkg",
      trig = "pkg",
      dscr = [[most used modules,notes:
        configuration: config
        loging: tracing,log
        error handling: anyhow,thiserror
        parser : nom,syn
        assertions : more_asserts,assertor,spectral
        tapping values: tap
        cli : clap
        camino : utf8 paths
        data parallelism lib: rayon
        async runtime environment: tokio
        http client: reqwest
        reflexion: quote
      ]],
    },
    fmt([[
      {}
    ]], {
      c(1, {
        t("config"),
        t("tracing"),
        t("anyhow"),
        t("thiserror"),
        t("tokio"),
        t("reqwest"),
        t("more_asserts"),
        t("assertor"),
        t("clap"),
        t("tap"),
        t("rayon"),
        t("camino"),
        t("itertools"),
        t("async-trait"),
      })
    }), {
    key = "modules"
  }),

  s(
    {
      name = "module-import",
      trig = "mod",
      dscr = "import module mod_name",
    },
    fmt([[
	  {1}mod {2}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        -- i(2, "name"),
        c(2, {
          sn(nil, {
            i(1, "name"),
            t(" ;")
          }),
          sn(nil, fmt([[
            {1} {{
              {2}
            }}
          ]], {
            i(1, "name"),
            i(2, "/* code */"),
          })),
        })
      }
    )
  ),

  s(
    {
      name = "use",
      trig = "use",
      dscr = "user module mod_name",
    },
    fmt([[
	  {1}use {2} ;
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "mod_name"),
      }
    )
  ),

  s(
    {
      name = "extern",
      trig = "extern",
      dscr = [[extern statement to foreign function interface(ffi),notes:]],
    },
    fmt([[
	  extern {{
        {}
	  }}
    ]],
      {
        i(1, "fn_signature"),
      }
    )
  ),

  s(
    {
      name = "unsafe",
      trig = "unsafe",
      dscr = [[unsafe statement declaration]],
    },
    fmt([[
	  unsafe {{
        {}
	  }}
    ]],
      {
        i(1, "fn_signature"),
      }
    )
  ),

  s(
    {
      name = "main",
      trig = "main",
      dscr = "main function declaration, note: main is entry point for program",
    },
    fmt([[
      fn main({1}){2}{{
        {3}
      }}
    ]],
      {
        c(1, {
          t "",
          i(1, "args"),
        }),
        c(2, {
          sn(2, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func",
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
        c(2, {
          i(1, "name"),
          t "",
        }),
        c(3, {
          i(1, "args"),
          t "",
        }),
        c(4, {
          sn(nil, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(5, "/* code */")
      }
    )
  ),

  s(
    {
      name = "closure",
      trig = "fnl",
      dscr = "closure declaration",
    },
    fmt([[
      {1}|{2}|{{ {} }}
    ]],
      {
        c(1, {
          t "",
          t "move ",
        }),
        c(2, {
          i(1, "args"),
          t "",
        }),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-generic",
      trig = "fng",
      dscr = "generic function declaration",
    },
    fmt([[
      {1}fn {2}{3}({4}){5}{{
        {6}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        sn(3, {
          t "<",
          i(1, "ptype"),
          t ">",
        }),
        i(4, "args"),
        c(5, {
          sn(1, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t "",
        }),
        i(6, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-parametric-trait",
      trig = "fnpt",
      dscr = "parametrict function declaration",
    },
    fmt([[
      {1}fn {2}{3}({4}){5}{6}{{
        {7}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        sn(3, {
          t "<",
          i(1, "ptype"),
          t ">",
        }),
        i(4, "args"),
        c(5, {
          sn(1, {
            t " -> ",
            i(4, "return_type"),
            t " ",
          }),
          t "",
        }),
        sn(6, {
          t "where ",
          i(1, "ptype:trait"),
        }),
        i(7, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "method",
      trig = "fnm",
      dscr = "method declaration, note: methdos are asociated with a datastruct & must be inside and impl{",
    },
    fmt([[
      {1}fn {2}({3}{4}){5}{{
        {6}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        c(3, {
          t "&self",
          t "&mut self",
        }),
        c(4, {
          sn(1, {
            t ",",
            i(1, "args"),
          }),
          t "",
        }),
        c(5, {
          sn(nil, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(6, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-const",
      trig = "fnc",
      dscr = "constant function declaration, note: constant functions is usable at compile time",
    },
    fmt([[
      {1}const fn {2}({3}){4}{{
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
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-async",
      trig = "fna",
      dscr = "async function declaration, note: async functions is usable at compile time",
    },
    fmt([[
      {1}async fn {2}({3}){4}{{
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
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-extern",
      trig = "fne",
      dscr = "external function declaration, note: function to use from/be called from another programming languaje",
    },
    fmt([[
      #[no_mangle]
      pub extern {} fn {2}({3}){4}{{
        {5}
      }}
    ]],
      {
        c(1, {
          t "C",
          t " ",
        }),
        i(2, "name"),
        c(3, {
          i(1, "args"),
          t "",
        }),
        c(4, {
          sn(nil, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-test",
      trig = "fnt",
      dscr = "testing function declaration",
    },
    fmt([[
      #[test]{1}
      {2}fn {3}_test({4}){5}{{
        {6}
      }}
    ]],
      {
        c(1, {
          t "",
          sn(1, {
            t({ "", "" }), -- new line
            c(1, {
              t "#[ignore]",
              t "#[should_panic]",
            })
          }),
        }),
        c(2, {
          t "",
          t "pub ",
        }),
        i(3, "name"),
        c(4, {
          i(1, "args"),
          t "",
        }),
        c(5, {
          sn(nil, {
            t " -> ",
            i(1, "return_type"),
            t " ",
          }),
          t " ",
        }),
        i(6, "/* code */"),
      }
    )
  ),

  ------------------------------------------------------
  --     				control structures   			--
  ------------------------------------------------------
  -- bifurcations/branchs
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
      name = "if-elseif-else",
      trig = "ifei",
      dscr = "if/elseif/else statement",
    },
    fmt([[
    if {1} {{
      {3}
    }} else if {2} {{
      {4}
    }} else {{
      {5}
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
        c(2, {
          i(1, "cond"),
          sn(1, {
            t("let "),
            i(1, "pattern"),
            t(" = "),
            i(2, "var"),
          }),
        }),
        i(3, "/* code */"),
        i(4, "/* code */"),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-ternary",
      trig = "ift",
      dscr = "if/else inline statement",
    },
    fmt([[
    if {1} {{ {2} }} else {{ {3} }}
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
      name = "if-in",
      trig = "ifi",
      dscr = "if/in statement",
    },
    fmt([[
    if {1} in {2} {{
      {3}
    }}
  ]] ,
      {
        i(1, "item"),
        i(2, "container"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-let",
      trig = "ifl",
      dscr = "if/let statement",
    },
    fmt([[
    if let {1} = {2} {{
      {3}
    }}
  ]] ,
      {
        i(1, "pattern"),
        i(2, "enum"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "match",
      trig = "match",
      dscr = "switch/match statement",
    },
    fmt([[
    match {1} {{
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
      name = "loop",
      trig = "loop",
      dscr = "infinite loop statement",
    },
    fmt([[
    loop {{
      {1}
    }}
  ]] ,
      {
        i(1, "/* code */"),
      }
    )
  ),

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
    for {1} in {2} {{
	  {3}
    }}
  ]] ,
      {
        i(1, "var"),
        i(2, "container/start..end"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "break",
      trig = "break",
      dscr = "break loop,note: may returning val",
    },
    fmt([[
    break {1};
  ]] ,
      {
        c(1, {
          sn(1, {
            i(1, "return_val"),
            t " ",
          }),
          t "",
        }),
      }
    )
  ),

  ------------------------------------------------------
  --     				data structures   				--
  ------------------------------------------------------
  s({
    name = "types",
    trig = "type",
    dscr = "rust builting types",
  }, {
    c(1, {
      t "isize",
      t "usize",
      t "char",
      t "str",
      t "String",
      t "Vec",
      t "HashMap",
      t "i8",
      t "i16",
      t "i32",
      t "i64",
      t "u8",
      t "u16",
      t "u32",
      t "u64",
      t "u128",
      t "f32",
      t "f64",
    }),
  }),

  s(
    {
      name = "type",
      trig = "type",
      dscr = "type alias declaration",
    },
    fmt([[
type {1} = {2} ;
]]   ,
      {
        i(1, "TypeAlias"),
        i(2, "BaseType"),
      }
    )
  ),

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
      name = "static",
      trig = "static",
      dscr = "static var/const declaration, note: these referes to global memory available trougth all program execution",
    },
    fmt([[
    static {1}{2} ;
  ]] ,
      {
        c(1, {
          t(""),
          t("mut "),
        }),
        i(2, "var/const"),
      }
    )
  ),

  s(
    {
      name = "let",
      trig = "let",
      dscr = "variable declaration, also posibble let (var1,var2,..varN) = (val1,val2,...valN)",
      --priority = 1000,
    },
    fmt([[
    let {1}{2}
  ]] ,
      {
        c(1, {
          t(""),
          t("mut "),
        }),
        c(2, {
          sn(nil, fmt([[
          {} = {} ;
        ]] , {
            i(1, "name"),
            i(2, "val"),
          })),
          sn(nil, fmt([[
          {} = {} else {{
            {}
          }} ;
        ]] , {
            i(1, "name"),
            i(2, "val"),
            i(3, "/* code */"),
          }))
        })
      }
    )
  ),

  s(
    {
      name = "let-closure",
      trig = "lfn",
      dscr = "closure declaration",
    },
    fmt([[
    let {1} = {2}|{3}| {4} ;
  ]] , {
      i(1, "name"),
      c(2, {
        t("move "),
        t(""),
      }),
      i(3, "args"),
      i(4, "ops"),
    }
    )
  ),

  s(
    {
      name = "let-tuple",
      trig = "tuple",
      dscr = "create a tuple with vals values_list of types types_list",
    },
    fmt([[
    let {1} : ({2}) = {3} ;
  ]] ,
      {
        i(1, "name"),
        i(2, "types_list"),
        i(3, "values_list"),
      }
    )
  ),

  s(
    {
      name = "let-array",
      trig = "leta",
      dscr = "declaration of array named arr_name of type arr_type with capacity arr_cap",
    },
    fmt([[
  let {1} : [{2},{3}] = [{4}] ;
  ]] ,
      {
        i(1, "arr_name"),
        i(2, "arr_type"),
        i(3, "arr_cap"),
        i(4, "vals"),
      }
    )
  ),

  s(
    {
      name = "let-slice",
      trig = "lets",
      dscr = "declaration of a slice named slice_name of type slice_type with values slice_vals",
    },
    fmt([[
    let {1} : [{2}] = [{3}] ;
  ]] ,
      {
        i(1, "slice_name"),
        i(2, "slice_type"),
        i(3, "slice_vals"),
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
    {1}struct {2}
  ]] ,
      {
        c(1, {
          t "",
          t "pub ",
        }),
        c(2, {
          sn(nil, fmt([[
      {} {{
        {}
      }}
    ]]     , {
            i(1, "name"),
            i(2, "/* field:type */"),
          })),
          sn(nil, fmt([[
      {}({})
    ]]     , {
            i(1, "name"),
            i(2, "type_list"),
          })),
        })
      }
    )
  ),

  s(
    {
      name = "struct-parametric",
      trig = "stp",
      dscr = "parametric struct declaration with parametric type ptype",
    },
    fmt([[
      {1}struct {2}<{3}>  {{
        {4}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        i(3, "ptype"),
        i(4, "/* field:type */"),
      }
    )
  ),

  s(
    {
      name = "struct-parametric-trait",
      trig = "stpt",
      dscr = "parametric struct declaration with parametric type ptype where ptype must implement some trait",
    },
    fmt([[
      {1}struct {2}<{3}> {4} {{
        {5}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        i(3, "ptype"),
        c(4, {
          t "",
          sn(1, {
            t "where ",
            i(1, "ptype:trait"),
          }),
        }),
        i(5, "/* field:type */"),
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

  s(
    {
      name = "enum-parametric",
      trig = "enump",
      dscr = "enum declaration with parametric type ptype, note:the enum size is only the size of bigger element",
    },
    fmt([[
      {1}enum {2}<{3}>  {{
	      {4}
      }}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        i(2, "name"),
        i(3, "ptype:trait"),
        i(4, "variant/variant(data)/variant{data}"),
      }
    )
  ),

  -- implementation
  s(
    {
      name = "impl",
      trig = "impl",
      dscr = "implementation of struct/enum name",
    },
    fmt([[
      impl {1} {{
	      {2}
      }}
    ]],
      {
        i(1, "name"),
        i(2, "/* function/method set */"),
      }
    )
  ),

  s(
    {
      name = "impl-parametric",
      trig = "implp",
      dscr = "implementation of struct/enum name for parametric type ptype",
    },
    fmt([[
      impl{2} {1}{3} {{
	    {4}
      }}
    ]],
      {
        i(1, "name"),
        c(2, {
          t "",
          sn(1, {
            t "<",
            i "ptype",
            t ">",
          }),
        }),
        sn(3, {
          t "<",
          i "ptype",
          t ">",
        }),
        i(4, "/* function/method set */"),
      }
    )
  ),

  s(
    {
      name = "impl-trait",
      trig = "implt",
      dscr = "implementation of trait for type",
    },
    fmt([[
      impl {1} for {2} {{
 	    {3}
      }}
    ]],
      {
        i(1, "trait"),
        i(2, "type"),
        i(3, "/* implementation */"),
      }
    )
  ),

  s(
    {
      name = "trait",
      trig = "trait",
      dscr = [[define trait ,notes:
        common behavior others can implement, traits permit asociate a method set with a data structure
        in case that supertrait exist must be implemented before subtrait could be implemented",
      ]],
    },
    fmt([[
      trait {1}{2}{{
	      {3}
      }}
    ]],
      {
        i(1, "name"),
        c(2, {
          sn(nil, {
            t(" : "),
            i(1, "supertrait"),
            t(" "),
          }),
          t(" ")
        }),
        i(3, "asociated types and/or function and/or method set*/"),
      }
    )
  ),

  ------------------------------------------------------
  --     				  	auxiliar 					--
  ------------------------------------------------------
  s(
    {
      name = "unsafe",
      trig = "unsafe",
      dscr = "unsafe block declaretions, note: unsafe code are low level code wich rust compiler can't assert good behavior",
    },
    fmt([[
      unsafe {{
	    {}
      }}
    ]],
      {
        i(1, "/* unsafe code */}"),
      }
    )
  ),

  s(
    {
      name = "result",
      trig = "Result",
      dscr = "result enum declaration with return type return_type and error type err_type",
    },
    fmt([[
      Result<{1},{2}>
    ]],
      {
        i(1, "return_type"),
        i(2, "err_type"),
      }
    )
  ),
  s(
    {
      name = "option",
      trig = "Option",
      dscr = "option enum declaration",
    },
    fmt([[
      Option<{}>
    ]],
      {
        i(1, "some_variant"),
      }
    )
  ),

  s(
    {
      name = "ok",
      trig = "Ok",
      dscr = "OK enum",
    },
    fmt([[
      Ok({}) ;
    ]],
      {
        i(1, "name"),
      }
    )
  ),

  s(
    {
      name = "err",
      trig = "err",
      dscr = "Err enum",
    },
    fmt([[
  Err({}) ;
]]   ,
      {
        i(1, "name"),
      }
    )
  ),

  s(
    {
      name = "Some",
      trig = "Some",
      dscr = "Some enum",
    },
    fmt([[
  Some({}) ;
]]   ,
      {
        i(1, "name"),
      }
    )
  ),

  s(
    {
      name = "None",
      trig = "None",
      dscr = "None enum",
    },
    fmt([[
      None() ;
    ]], {}
    )
  ),

  ------------------------------------------------------
  --  				  	macros				          --
  ------------------------------------------------------
  s(
    {
      name = "macro-declarative",
      trig = "macro",
      dscr = "macro declaration",
    },
    fmt([[
      {}
      macro_rules! {} {{
        ({}) => {{
            {}
        }};
      }}
    ]], {
        c(1,{
            t("#[macro_export]"),
            t(""),
        }),
        i(2,"name"),
        i(3,"args"),
        i(4,"/* code */"),
    })
  ),

  s(
    {
      name = "macro-function",
      trig = "macro-fn",
      dscr = "macro declaration",
    },
    fmt([[
        use proc_macro ;
        
        #[proc_macro]
        pub fn {}({}) -> TokenStream {{
            {}
        }}
    ]], {
        i(1,"name"),
        c(2,{
            t("input: TokenStream"),
            t("in1: TokenStream , in2:TokenStream"),
        }),
        i(3,"/* code */"),
    })
  ),

  s(
    {
      name = "macro-derive",
      trig = "macro-derive",
      dscr = "macro declaration",
    },
    fmt([[
        use proc_macro ;
        
        #[proc_macro_derive({})]
        pub fn {}(item: TokenStream) -> TokenStream {{
            {}
        }}
    ]], {
        i(1,"DeriveKey,attribute(AttributeKey)"),
        i(2,"name"),
        i(3,"/* code */"),
    })
  ),

  s(
    {
      name = "macro-attribute",
      trig = "macro-attribute",
      dscr = "macro declaration",
    },
    fmt([[
        use proc_macro ;
        
        #[proc_macro_attribute]
        pub fn {}({}) -> TokenStream {{
            {}
        }}
    ]], {
        i(1,"name"),
        i(2,"args: TokenStream"),
        i(3,"/* code */"),
    })
  ),


  ------------------------------------------------------
  --  				  	configuration				  --
  ------------------------------------------------------
  s(
    {
      name = "config",
      trig = "config",
      dscr = "basic config",
    },
    fmt([[
      use config;
      use serde;

      const CONFIG_FILE: &'static str = "{}";

      #[derive(Debug, serde::Deserialize)]
      pub struct Configuration {{
        {}
      }}

      impl Default for Configuration {{
          fn default() -> Self {{
              return Configuration {{
                {}
              }};
          }}
      }}

      pub fn init_config() -> Configuration {{
          let config: Configuration = config::Config::builder()
              .add_source(config::File::with_name(CONFIG_FILE))
              .build()
              .expect("failed to load configuration")
              .try_deserialize()
              .expect("failed to serialize configuration");
          return config;
      }}
    ]], {
      i(1, "path to config file"),
      i(2, "config data/fields"),
      rep(2)
    })
  ),

})
