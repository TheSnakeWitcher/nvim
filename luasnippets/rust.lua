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
ls.add_snippets("rust", {

  ------------------------------------------------------
  --     				   codebase structures   			        --
  ------------------------------------------------------
  s(
    {
      name = "module",
      trig = "mod",
      dscr = "import/declare module",
    },
    fmt([[
        {attribute}
        {}mod {}
    ]],
      {
        c(1, {
          t "",
          t "pub ",
        }),
        c(2, {
          sn(nil, {
            i(1, "name"),
            t(" ;")
          }),
          sn(nil, fmt([[
            {1} {{
              use super::* ;
              {2}
            }}
          ]], {
            i(1, "name"),
            i(2, "/* code */"),
          })),
        }),
        attribute = m({2},"test", "#[cfg(test)]")
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
        -- m(2,"<),
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
      name = "function-method",
      trig = "fm",
      dscr = "method declaration, note: methdos are asociated with a datastruct & must be inside and impl",
    },
    fmt([[
      fn {1}({2}{3}){4}{{
        {5}
      }}
    ]],
      {
        -- c(1, {
        --   t "",
        --   t "pub ",
        -- }),
        i(1, "name"),
        c(2, {
          t "&self",
          t "&mut self",
          t "self",
        }),
        c(3, {
          sn(1, {
            t ",",
            i(1, "args"),
          }),
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
      name = "func-parametric-trait",
      trig = "fngt",
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
      name = "func-extern",
      trig = "fne",
      dscr = [[external function declaration, note: function to interoperate with another programming languaje
            c => c
            system => java
      ]],
    },
    fmt([[
      #[no_mangle]
      pub extern {} fn {2}({3}){4}{{
        {5}
      }}
    ]],
      {
        c(1, {
          t "\"C\"",
          t "\"system\"",
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
      snippetType = "autosnippet",
    },
    fmt([[
      #[test]{1}
      {2}fn {3}({4}){5}{{
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

  ------------------------------------------------------
  --     				data structures   				--
  ------------------------------------------------------
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
        -- d(1,function()
        --     local bufnr = vim.api.nvim_get_current_buf()
        --     local lang  = "rust"
        --     local structs_names_query = [[( (struct_item (type_identifier) @struct_name ) )]]
        --     local trait_names_query = [[( (trait_item (type_identifier) @trait_name ) )]]
        --
        --     local parser = vim.treesitter.get_parser(bufnr ,lang,{})
        --     local tree = parser:parse()[1]
        --     local tree_root = tree:root()
        --     local struct_names = vim.treesitter.query.parse(lang,structs_names_query)
        --
        --     local structs_ids = {}
        --     for id,node,metadata in struct_names:iter_captures(tree_root,bufnr) do
        --         local node_text = vim.treesitter.get_node_text(node,bufnr)
        --         table.insert(structs_ids,node_text)
        --     end
        --     return sn(nil,c(structs_ids))
        -- end,{},{}),
        i(1, "name"),
        i(2, "/* function/method set */"),
        -- posible implementation for when `name` is a trait search his definition and print
        -- local trait_names = vim.treesitter.query.parse(lang,trait_names_query)
        -- local traits = {}
        -- for id,node,metadata in trait_names:iter_captures(tree_root,bufnr) do
        --     local data = vim.treesitter.get_node_text(node,bufnr)
        --     table.insert(traits,data)
        -- end
      }
    )
  ),

  s(
    {
      name = "impl-generic",
      trig = "implg",
      dscr = "implementation of struct/enum name for generic type ptype",
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

})
