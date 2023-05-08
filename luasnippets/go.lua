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
local conds_expand = require "luasnip.extras.conditions.expand"
local conds_show = require "luasnip.extras.conditions.show"
local ai = require "luasnip.nodes.absolute_indexer"
local m = extras.match
local l = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

-- common nodes

ls.add_snippets("go", {

  ------------------------------------------------------
  --     				codebase structures   			--
  ------------------------------------------------------
  s(
    {
      name = "kkk2",
      trig = "kkk2",
    },
    fmt([[
	  package {}

	  {}
	]]  ,
      {
        i(1, "name"),
        c(2, {
          t "",
          t "maininit",
          t "main",
        }),
      }
    )
  ),

  s(
    {
      name = "package",
      trig = "package",
      dscr = "package declaration",
    },
    fmt([[
	  package {}

	  {}
	]]  ,
      {
        i(1, "name"),
        c(2, {
          t "",
          t "maininit",
          t "main",
        }),
      }
    )
  ),

  s(
    {
      name = "import",
      trig = "im",
      dscr = "import a single package",
    },
    fmt([[
	  import {}
	]]  ,
      {
        i(1, "name"),
      }
    )
  ),

  s(
    {
      name = "import-block",
      trig = "ims",
      dscr = "imports a group of packages",
    },
    fmt([[
	  import ((
 	 	{2}"{1}"
 	 	{4}"{3}"
	  ))
	]]  ,
      {
        i(1, "pkg"),
        c(2, {
          t "",
          sn(1, {
            i(1, "alias"),
            t " ",
          }),
        }),
        i(3, "pkg"),
        c(4, {
          t "",
          sn(1, {
            i(1, "alias"),
            t " ",
          }),
        }),
      }
    )
  ),

  s(
    {
      name = "init",
      trig = "init",
      dscr = "init func",
    },
    fmt(
      [[
		func init() {{
			{1}
		}}
	]]    ,
      {
        i(1, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "main",
      trig = "main",
      dscr = "main func",
    },
    fmt(
      [[
		func main() {{
			{1}
		}}
	]]    ,
      {
        i(1, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "init-main",
      trig = "maininit",
      dscr = "init/main funcs",
    },
    fmt(
      [[
		func init() {{
			{1}
		}}

		func main() {{
			{2}
		}}
	]]    ,
      {
        i(1, "/* code */"),
        i(2, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "main-test",
      trig = "main",
      dscr = "declare a main test function",
    },
    fmt(
      [[
		func TestMain(t *testing.M) {{
			{1}
		}}
	]]    ,
      {
        i(1, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func",
      trig = "fn",
      dscr = "function declaration",
    },
    fmt(
      [[
      	func {1}({2}) {3}{{
      	  {4}
      	}}
	]]    ,
      {
        c(1, {
          i(1,"name"),
          t "",
        }),
        c(2, {
          i (1,"args"),
          t "",
        }),
        c(3, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(4, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-generation",
      trig = "fng",
      dscr = "generic function declaration, note: ptype stands for parametric_type",
    },
    fmt(
      [[
      	func {1}[{2}]({3}) {4}{{
      	  {5}
      	}}
	]]    ,
      {
        i(1, "name"),
        i(2, "arg ptype"),
        c(3, {
          t "args",
          t "",
        }),
        c(4, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "func-test",
      trig = "fnt",
      dscr = "function test",
    },
    fmt(
      [[
      	func Test{1}(t *testing.T{2}) {3} {{
      	  {4}
      	}}
	]]    ,
      {
        i(1, "name"),
        c(2, {
          sn(1, {
            t ", ",
            i(1, "args"),
          }),
          t "",
        }),
        c(3, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(4, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "funct-benchmark",
      trig = "fnb",
      dscr = "function to benchmark",
    },
    fmt(
      [[
      	func Benchmark{1}(b *testing.B{2}) {3}{{
      	  {4}
      	}}
	]]    ,
      {
        i(1, "name"),
        c(2, {
          t "",
          sn(1, {
            t ", ",
            i(1, "args"),
          }),
        }),
        c(3, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(4, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "method",
      trig = "fm",
      dscr = "method",
    },
    fmt([[
      func (self {4}){1}({2}) {3}{{
        {5}
      }}
	]]  ,
      {
        i(1,"name"),
        c(2, {
          i(1,"args"),
          t "",
        }),
        c(3, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(4, "ReceiverType"),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "defered-func-anonimous",
      trig = "defer",
      dscr = "defered anonimous function",
    },
    fmt([[
      defer func ({1}) {2}{{
        {3}
      }}()
	]]  ,
      {
        c(1, {
          t "args",
          t "",
        }),
        c(2, {
          sn(nil, {
            i(1, "return_types"),
            t " ",
          }),
          t "",
        }),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "defered-func-call",
      trig = "defer",
      dscr = "defered function call",
    },
    fmt([[
      defer {}
    ]],
      {
        i(1, "name"),
      }
    )
  ),

  -- ------------------------------------------------------
  -- --     				control structures   			--
  -- ------------------------------------------------------
  -- -- bifurcation
  s(
    {
      name = "ifer",
      trig = "ifer,",
      dscr = "ifer",
    },
    fmt(
      [[
		if err != nil {{
			{1}
		}}
	]]    ,
      {
        i(1, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if",
      trig = "if,",
      dscr = "if",
    },
    fmt([[
      if {1} {{
        {2}
      }}
	]]  ,
      {
        i(1, "cond"),
        i(2, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-else",
      trig = "ife",
      dscr = "if/else",
    },
    fmt(
      [[
		if {1} {{
			{2}
		}} else {{
			{3}
		}}
	]]    ,
      {
        i(1, "cond"),
        i(2, "/* code */"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-else_if",
      trig = "ife,",
      dscr = "if/else_if/else",
    },
    fmt(
      [[
		if {1} {{
			{3}
		}} else if {2} {{
			{4}
		}} else {{
			{5}
		}}
	]]    ,
      {
        i(1, "cond"),
        i(2, "cond"),
        i(3, "/* code */"),
        i(4, "/* code */"),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "if-init",
      trig = "ifi,",
      dscr = "if/init",
    },
    fmt([[
      if {1} ; {2} {{
        {3}
      }}
	]]  ,
      {
        i(1, "init"),
        i(2, "cond"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "switch-condition",
      trig = "switch,",
      dscr = "switch conditions",
    },
    fmt([[
      switch {{
        case {1} :
          {3}
        case {2} :
          {4}
        default :
          {5}
      }}
    ]],
      {
        i(1, "cond1"),
        i(2, "cond2"),
        i(3, "/* code */"),
        i(4, "/* code */"),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "switch-expresion",
      trig = "switch",
      dscr = "switch expression",
    },
    fmt(
      [[
		switch {1} {{
			case {2} :
				{4}
			case {3} :
				{5}
			default :
				{6}
		}}
	]]    ,
      {
        i(1, "exp"),
        i(2, "cond1"),
        i(3, "cond2"),
        i(4, "/* code */"),
        i(5, "/* code */"),
        i(6, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "switch-init",
      trig = "switchi",
      dscr = "switch expression",
    },
    fmt(
      [[
		switch {1} ; {2} {{
			case {3} :
				{5}
			case {4} :
				{6}
			default:
				{7}
		}}
	]]    ,
      {
        i(1, "exp"),
        i(2, "var"),
        i(3, "cond1"),
        i(4, "cond2"),
        i(5, "/* code */"),
        i(6, "/* code */"),
        i(7, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "switch-type",
      trig = "switcht",
      dscr = "switch type",
    },
    fmt([[
      switch {1}.({2}) {{
        case {3} :
          {5}
        case {4} :
          {6}
        default :
          {7}
      }}
    ]],
      {
        i(1, "interface"),
        i(2, "type"),
        i(3, "cond1"),
        i(4, "cond2"),
        i(5, "/* code */"),
        i(6, "/* code */"),
        i(7, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "fallthrough",
      trig = "fallthrough,",
      dscr = "",
    },
    fmt([[
      {}
	]]  ,
      {
        t "fallthrough",
      }
    )
  ),
  -- -- loops
  s(
    {
      name = "for",
      trig = "forl",
      dscr = "for infinite",
    },
    fmt(
      [[
		for {{
			{1}
		}}
	]]    ,
      {
        i(1, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "for-condition",
      trig = "forc",
      dscr = "for conditional",
    },
    fmt(
      [[
		for {1} {{
			{2}
		}}
	]]    ,
      {
        i(1, "cond"),
        i(2, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "for-counter",
      trig = "for",
      dscr = "for counter controlled",
    },
    fmt(
      [[
		for {1} ; {2} ; {3} {{
			{4}
		}}

	]]    ,
      {
        i(1, "vars"),
        i(2, "cond"),
        i(3, "change"),
        i(4, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "for-range",
      trig = "forr,",
      dscr = "for range",
    },
    fmt(
      [[
		for {1} , {2} := range {3} {{
			{4}
		}}

	]]    ,
      {
        i(1, "index"),
        i(2, "value"),
        i(3, "conainer"),
        i(4, "/* code */"),
      }
    )
  ),

  -- -- errors
  s(
    {
      name = "errors-new",
      trig = "err,",
      dscr = "get type and method set",
    },
    fmt(
      [[
		errors.New({})
	]]    ,
      {
        i(1, "ErrorMsg"),
      }
    )
  ),

  s(
    {
      name = "panic",
      trig = "panic,",
      dscr = "panic call",
    },
    fmt(
      [[
		panic({})
	]]    ,
      {
        i(1, "PanicMsg"),
      }
    )
  ),

  s(
    {
      name = "recover",
      trig = "recover,",
      dscr = "recover call",
    },
    fmt([[
		{}	
	]]  ,
      {
        c(1, {
          sn(nil, fmt([[
		    defer func() {{
		      if err := recover() ; err != nil {{
			      {}
		      }}
		    }}
	      ]]  ,
            {
              i(1, "/* code */"),
            }
          )),
          t("err := recover()"),
        })
      }
    )
  ),

  --------------------------------------------------------
  ----     				 data structures    			--
  --------------------------------------------------------
  s(
    {
      name = "types",
      trig = "types,",
      dscr = "builtin types",
    },
    fmt(
      [[
		{}
	]]    ,
      {
        c(1, {
          sn(1, {
            t "channel ",
            i(1, "type"),
          }),
          sn(2, {
            t "map[",
            i(1, "key_type"),
            t "]",
            i(2, "val_type"),
          }),
          t "string",
          t "int8",
          t "int16",
          t "int32",
          t "int64",
          t "uint8",
          t "uint16",
          t "uint32",
          t "uint64",
          t "float32",
          t "float64",
          t "complex64",
          t "complex128",
        }),
      }
    )
  ),

  s(
    {
      name = "const",
      trig = "const",
      dscr = "constant declaration",
    },
    fmt([[
	  const {}
	]]  ,
      {
        c(1, {
          sn(nil, fmt([[
            {1} {2} = {3}
          ]],
            {
              i(1, "name"),
              i(2, "type"),
              i(3, "value"),
            }
          )),
          sn(nil, fmt([[
            (
              {1} {2}
              {3} {4}
            )
          ]],
            {
              i(1, "name"),
              i(2, "type"),
              i(3, "name"),
              i(4, "type"),
            }
          )),
        })
      }
    )
  ),

  s(
    {
      name = "var",
      trig = "var,",
      dscr = "variable declaration",
    },
    fmt(
      [[
		var {}
	]]    ,
      {
        c(1, {
          sn(nil, fmt([[
		      {1} {2}
	      ]]  ,
            {
              i(1, "name"),
              c(2, {
                sn(1, {
                  i(1, "type"),
                  t " = ",
                  i(2, "val"),
                }),
                sn(2, {
                  t ":= ",
                  i(1, "val"),
                }),
              }),
            }
          )),
          sn(nil, fmt([[
            (
              {1} {2}
              {3} {4}
            )
	      ]]  ,
            {
              i(1, "name"),
              c(2, {
                sn(1, {
                  i(1, "type"),
                  t " = ",
                  i(2, "val"),
                }),
                sn(2, {
                  t " := ",
                  i(1, "val"),
                }),
              }),
              i(3, "name"),
              c(4, {
                sn(1, {
                  i(1, "type"),
                  t " = ",
                  i(2, "val"),
                }),
                sn(2, {
                  t " := ",
                  i(1, "val"),
                }),
              }),
            }
          )),
        })
      }
    )
  ),

  s(
    {
      name = "type",
      trig = "type,",
      dscr = [[note:
        type declaration wich is different from basetype but can be assigned with the same tipe of values
      ]],
    },
    fmt([[
      type {}
    ]],
      {
        c(1, {
          sn(nil, fmt([[
            {1} {2}
          ]],
            {
              i(1, "name"),
              i(2, "basetype"),
            }
          )),
          sn(nil, fmt([[
            (
              {1} {2}
              {3} {4}
            )
          ]],
            {
              i(1, "name"),
              i(2, "type"),
              i(3, "name"),
              i(4, "type"),
            }
          )),
          sn(nil,
            fmt([[
              {1} = {2}
            ]],
              {
                i(1, "name"),
                i(2, "basetype"),
              }
            )),
        })
      }
    )
  ),

  s(
    {
      name = "type-assertion",
      trig = "type,",
      dscr = "type assetion of an interface",
    },
    fmt(
      [[
		{1}.({2})
	]]    ,
      {
        i(1, "interface"),
        i(2, "type"),
      }
    )
  ),

  s(
    {
      name = "new",
      trig = "new,",
      dscr = "make a new instance of type and return a *type",
    },
    fmt(
      [[
		new({})
	]]    ,
      {
        i(1, "type"),
      }
    )
  ),

  s(
    {
      name = "make",
      trig = "make,",
      dscr = "make a new instance of type and return a type",
    },
    fmt(
      [[
		make({})
	]]    ,
      {
        i(1, "type"),
      }
    )
  ),

  s(
    {
      name = "make-chan",
      trig = "chan,",
      dscr = [[
		make a channel
		channels created without make function is a nil channel
		nil channel are allways closed and return errors when try to send/receive
		]]   ,
    },
    fmt(
      [[
		make(chan {1}{2})
	]]    ,
      {
        i(1, "type/<-type/type<-"),
        sn(2, {
          t ", ",
          i(1, "cap"),
        }),
      }
    )
  ),

  s(
    {
      name = "struct",
      trig = "struct",
      dscr = "struct type",
    },
    fmt([[
		{1}struct {{ {2} }}
	]]  ,
      {
        c(1, {
          sn(nil, {
            t("type "),
            i(1, "name"),
            t(" "),
          }),
          i(1, ""),
        }),
        i(2, "/*field type `annotation`*/"),
      }
    )
  ),

  s(
    {
      name = "interface",
      trig = "interface",
      dscr = "interface type",
    },
    fmt(
      [[
		type {1} interface {{
			{2}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "/* method set */"),
      }
    )
  ),

  s(
    {
      name = "interface-constraint",
      trig = "[iw, interface],",
      dscr = "interface constraint type to use in generic functions, note: this is go union",
    },
    fmt(
      [[
		type {1} interface {{
			{2}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "{0:/* type1 | type2 | ... typeN */}"),
      }
    )
  ),

  s(
    {
      name = "array-init",
      trig = "arr",
      dscr = "array init",
    },
    fmt(
      [[
		{1} := [{2}]{3}{4}
	]]    ,
      {
        i(1, "name"),
        i(2, "number"),
        i(3, "type"),
        i(4, "values"),
      }
    )
  ),
  -- ------------------------------------------------------
  -- --     	 multithread/concurency structures 		   --
  -- ------------------------------------------------------
  s(
    {
      name = "go-func",
      trig = "gfn",
      dscr = "goroutine function",
    },
    fmt(
      [[
		go {}
	]]    ,
      {
        c(1, {
          i(1, "name"),
          sn(1, {
            t "func (",
            i(1, "args"),
            t ") ",
            i(2, "return_type"),
            t { " {", "" },
            i(3, "/* code */"),
            t { "", "}" },
          }),
        }),
      }
    )
  ),

  s(
    {
      name = "channel-close",
      trig = "close,",
      dscr = "close a channel,send data trought a closed channel panics",
    },
    fmt(
      [[
		close({})
	]]    ,
      {
        i(1, "ch"),
      }
    )
  ),

  s(
    {
      name = "channel-select",
      trig = "select,",
      dscr = "run code accoding to enable a channel otherwise default block,default is always executable",
    },
    fmt(
      [[
		select {{
			case {1} :
				{3}
			case {2} :
				{4}
			default :
				{5}
		}}
	]]    ,
      {
        i(1, "ch_op1"),
        i(2, "ch_op2"),
        i(3, "/* code */"),
        i(4, "/* code */"),
        i(5, "/* code */"),
      }
    )
  ),

  ------------------------------------------------------
  --     					packages 				 	--
  ------------------------------------------------------
  s(
    {
      name = "pkg",
      trig = "pkg",
      dscr = [[go util 3rd party pkg:
          testify      : testing
          viper        : configuration layer
          zerolog      : logs
          echo         : servers
          go-ethereum  : ethereum blockchain interaction
          grpc         : grpc
          go-color     : colorize cli output
          conc         : better strucutred concurrency

          -- formats
          proto        : protobuf
          yaml         : yaml format

          -- dbs
          mongo-driver : mongodb driver
          pg           : postgrs library
          pgx          : low level library only for postgres

          -- utility
          mapstructure : data structure mappings utility
          structs      : structs handling utility
          slices       : slices handling utility
          maps         : maps handling utility"',
          dic          : dic handling utility"',t
          lo           : iterator utility
          go-color     : coloring output utility

          -- social
          godiscord    : discord social net
      ]],
    },
    fmt(
      [[
		{}
	]]    ,
      {
        c(1, {
          t '"github.com/stretchr/testify"',
          t '"github.com/spf13/viper"',
          t '"github.com/rs/zerolog"',
          t '"github.com/labstack/echo/v4"',
          t '"github.com/fatih/structs"',
          t '"golang.org/x/exp/slices"',
          t '"golang.org/x/exp/maps"',
          t '"github.com/srfrog/dict"',
          t '"github.com/mitchellh/mapstructure"',
          t '"gopkg.in/yaml.v3"',
          t '"github.com/ethereum/go-ethereum"',
          t '"go.mongodb.org/mongo-driver"',
          t '"google.golang.org/grpc"',
          t '"google.golang.org/protobuf/proto"',
          t '"github.com/jackc/pgx"',
          t '"github.com/sourcegraph/conc"',
          t '"github.com/bwmarring/discordgo"',
          t '"github.com/sanber/lo@v1"',
          t '"github.com/TwiN/go-color"',
        }),
      }
    )
  ),

  s(
    {
      name = "zerolog-basic-temp",
      trig = "zerolog",
      dscr = "create a logger in temp directory",
    },
    fmt(
      [[
		LogFile,err := ioutil.TempFile(os.TempDir(),{}.log\)
		if err != nil {{
			panic(err)
		}}

		defer LogFile.Close(),
		fileWriter := zerolog.New(LogFile).With().Timestamp().Logger()
		multiOutputWriter := zerolog.MultiLevelWriter(os.Stdout, fileWriter)
		Logger = zerolog.New(multiOutputWriter).With().Timestamp().Logger()
	]]    ,
      {
        i(1, "file"),
      }
    )
  ),

  s(
    {
      name = "zerolog-basic",
      trig = "zerolog",
      dscr = "create a logger",
    },
    fmt(
      [[
		LogFile, err := os.OpenFile("{}"),os.O_APPEND|os.O_WRONLY, 0666)
		if err != nil {{
			panic(err)
		}}

		defer LogFile.Close(),
		fileWriter := zerolog.New(LogFile).With().Timestamp().Logger()
		multiOutputWriter := zerolog.MultiLevelWriter(os.Stdout, fileWriter)
		Logger = zerolog.New(multiOutputWriter).With().Timestamp().Logger()
	]]    ,
      {
        i(1, "file"),
      }
    )
  ),

  s(
    {
      name = "zerolog-basic-temp-console",
      trig = "zerolog",
      dscr = "create a console logger wich is more nice but with less performance",
    },
    fmt(
      [[
		logFile, err := os.OpenFile("{}",os.O_APPEND|os.O_WRONLY, 0666)
		if err != nil {{
			panic(err)
		}}

		defer logFile.Close()
		fileWriter := zerolog.New(logFile).With().Timestamp().Logger()
		multiOutputWriter := zerolog.MultiLevelWriter(zerolog.ConsoleWriter{{Os: os.Stdout}}, fileWriter)
		Logger = zerolog.New(multiOutputWriter).With().Timestamp().Logger()
	]]    ,
      {
        i(1, "file"),
      }
    )
  ),

  -- -- templates
  s(
    {
      name = "template-folder",
      trig = "tmpl",
      dscr = "var to contain the template folder",
    },
    fmt(
      [[
		var tmpls = template.Must(template.ParseGlob(i(1,"TemplateFolderPath"),))
	]]    ,
      {}
    )
  ),

  s(
    {
      name = "template-selection",
      trig = "tmple",
      dscr = "var to contain the template folder",
    },
    fmt(
      [[
		tmpls.ExecuteTemplate({},{},nil)
	]]    ,
      {
        i(1, "buffer"),
        i(1, "TmplName"),
      }
    )
  ),

  -- -- http
  s(
    {
      name = "http-handle-func",
      trig = "http",
      dscr = "when find pattern call handler function",
    },
    fmt(
      [[
		func {1}(w http.ResponseWriter,r *http.Request) {{
			{2}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "/* code */"),
      }
    )
  ),

  -- -- rpc
  s(
    {
      name = "rpc-register",
      trig = "rpc,",
      dscr = "register in rpc-server to make available for clients",
    },
    fmt(
      [[
		rpc.Register({})
	]]    ,
      {
        i(1, "Interface"),
      }
    )
  ),

  s(
    {
      name = "rpc-func-call",
      trig = "rpc,",
      dscr = "rpc function call",
    },
    fmt(
      [[
		{1},({2},{3})
	]]    ,
      {
        i(1, "Name"),
        i(2, "InArg"),
        i(3, "OutArg"),
      }
    )
  ),

  s(
    {
      name = "rpc-func-def",
      trig = "rpc,",
      dscr = "rpc function implementation",
    },
    fmt(
      [[
		func (self *{1}){2}(*{3},*{4}) error {{
			{5}
		}}
	]]    ,
      {
        i(1, "Receiver"),
        i(2, "Name"),
        i(3, "InArg"),
        i(4, "OutArg"),
        i(5, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "rpc-server-http",
      trig = "rpc,",
      dscr = "rpc http server basic implementation",
    },
    fmt(
      [[
		rpc.Register({1})
		rpc.HandleHTTP()
		err := http.ListenAndServe({2},{3})
	]]    ,
      {
        i(1, "obj_with_methods"),
        i(2, "addr"),
        i(3, "srv"),
      }
    )
  ),

  s(
    {
      name = "rpc-client-http",
      trig = "rpc,",
      dscr = "rpc http client basic implementation",
    },
    fmt(
      [[
  	  	client,err := rpc.DialHTTP({1},{2})
  	  	if err != nil {{
  	  	  	{3}
		}}

  	  	err = client.Call(\call\,inArg,outArg)
  	  	if err != nil {{
  	  	  	{4}
  	  	}}
	]]    ,
      {
        i(1, "tcp"),
        i(2, "srv_addr+srv_port"),
        i(3, "/* code */"),
        i(4, "/* code */"),
      }
    )
  ),

  -- json
  s(
    {
      name = "json-read",
      trig = "jsonr,",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
		file = {1}
      	var data {2}
      	fileData,err := ioutil.ReadFile(file)
      	if err != nil {{
      		fmt.Println(err)
      	}}
      	json.Unmarshal(fileData,&data)
	]]    ,
      {
        i(1, "file"),
        i(2, "map[string]any"),
      }
    )
  ),

  s(
    {
      name = "json-read-decoder",
      trig = "jsonrd,",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
      	file,err := os.Open({1})
      	if err != nil {{
      		fmt.Println(err)
      	}}
      	var data map[string]any
      	json.NewDecoder(file).Decode(data)
	]]    ,
      {
        i(1, "fileName"),
      }
    )
  ),

  s(
    {
      name = "json-write",
      trig = "jsonw,",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
      	content,err := json.MarshalIndent(data," ","\t")
      	if err != nil {{
      		fmt.Println(err)
      	}}
      	ioutil.WriteFile(file,content,0644)
	]]    ,
      {}
    )
  ),

  s(
    {
      name = "json-write-decoder",
      trig = "jsonwd,",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
      	file = {1}
      	var data {2}
      	file,err := os.OpenFile(file,os.O_CREATE|os.O_APPEND,os.ModePerm)
      	if err != nil {{
      		fmt.Println(err)
      	}}
      	json.NewEncoder(file).Encode(data)
	]]    ,
      {
        i(1, "file"),
        i(2, "map[string]any"),
      }
    )
  ),

  s(
    {
      name = "encoding-save-json",
      trig = "json,",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
		saveJSON({1},{2})
	]]    ,
      {
        i(1, "file string"),
        i(2, "key interface{}"),
      }
    )
  ),

  s(
    {
      name = "encoding-load-json",
      trig = "json,",
      dscr = "call loadJSON func",
    },
    fmt(
      [[
		loadJSON({1},{2})
	]]    ,
      {
        i(1, "file string"),
        i(2, "key interface{}"),
      }
    )
  ),

  s(
    {
      name = "encoding-save-json-impl",
      trig = "json",
      dscr = "call saveJSON func",
    },
    fmt(
      [[
      	saveJSON(file string,key interface{{}} {{
      		outFile,err := os.Create(file)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
			}}

      		encoder := json.NewEncoder(file)
      		err = encoder.Encode(key)
      		if err != nil {{
      			fmt.Println("Error:",err.Error())
      		}}

      		outFile.Close()
      	}}
	]]    ,
      {}
    )
  ),

  s(
    {
      name = "encoding-load-json-impl",
      trig = "json,",
      dscr = "call loadJSON func",
    },
    fmt(
      [[
      	loadJSON(file string,key interface{{}} {{
      		inFile,err := os.Open(file)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
      		}}

      		decoder := json.NewDecoder(file)
      		err = decoder.Decode(key)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
      		}}

      		inFile.Close()
      	}}
	]]    ,
      {}
    )
  ),

  -- -- gob
  s(
    {
      name = "encoding-save-gob",
      trig = "gob,",
      dscr = "call saveGOB func",
    },
    fmt(
      [[
		saveGOB({1},{2})
	]]    ,
      {
        i(1, "file string"),
        i(2, "key interface{}"),
      }
    )
  ),

  s(
    {
      name = "encoding-load-gob",
      trig = "gob,",
      dscr = "call loadGOB func",
    },
    fmt(
      [[
		loadGOB({1},{2})
	]]    ,
      {
        i(1, "file string"),
        i(2, "key interface{}"),
      }
    )
  ),

  s(
    {
      name = "encoding-save-gob-impl",
      trig = "gob,",
      dscr = "saveGOB implementation",
    },
    fmt(
      [[
      	saveGOB(file string,key interface{{}} {{
      		outFile,err := os.Create(file)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
      		}}

      		encoder := gob.NewEncoder(outFile)
      		err = Encoder.Encode(key)
      		if err != nil {{
      			fmt.Println(\Error:\,err.Error())
      		}}

      		outFile.Close()
      	}}
	]]    ,
      {}
    )
  ),

  s(
    {
      name = "encoding-load-gob-impl",
      trig = "gob,",
      dscr = "loadGOB implementation",
    },
    fmt(
      [[
      	loadGOB(file string,key interface{{}} {{
      		inFile,err := os.Open(file)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
      		}}

      		decoder := gob.NewDecoder(inFile)
      		err = decoder.Decode(key)
      		if err != nil {{
      			fmt.Println("error:",err.Error())
      		}}

      		inFile.Close(),
    	}}
	]]    ,
      {}
    )
  ),

  -- -- viper
  s(
    {
      name = "viper",
      trig = "viper,",
      dscr = "config code using viper",
    },
    fmt(
      [[
		package main

		import (
			"github.com/spf13/viper"

			"errors"
		)

		const (
			ConfigPath string = "{1}"
			ConfigFileName string = "{2}"
			ConfigFileType string = "{3}"
		)

		type configuration struct {{
			{4} `mapstructure:{5}`
		}}

		var Config configuration

		func InitConfigFrom(path string) (err error) {{
			viper.SetConfigName(ConfigFileName)
			viper.SetConfigType(ConfigFileType)
			viper.AddConfigPath(ConfigPath)

			err = viper.ReadInConfig()
			if err != nil {{
				panic(errors.New("failed to load config file"))
			}}

			err = viper.Unmarshal(&Config)
			if err != nil {{
				panic(errors.New("failed to save config"))
			}}

			return nil
		}}
	]]    ,
      {
        i(1, "config file path"),
        i(2, "config file name"),
        c(3, {
          t "toml",
          t "yaml",
          t "json",
          t "env",
          t "xml",
        }),
        i(4, "env_vars"),
        rep(4),
      }
    )
  ),

  s(
    {
      name = "viper-log",
      trig = "viperl,",
      dscr = "config code using viper & zerolog",
    },
    fmt(
      [[
		package main

		import (
			"github.com/spf13/viper"
            "github.com/rs/zerolog"

			"os"
			"errors"
		)

		const (
			ConfigPath string = {1}
			ConfigFileName string = {2}
			ConfigFileType string = {3}
		)

		type configuration struct {{
			LogFile string `mapstructure:LogFile`
			{4} `mapstructure:{5}`
		}}

		var (
			Config configuration
			LogFile *os.File
			Logger zerolog.Logger
		)

		func InitConfigFrom(path string) (err error) {{
			viper.SetConfigName(ConfigFileName)
			viper.SetConfigType(ConfigFileType)
			viper.AddConfigPath(ConfigPath)

			err = viper.ReadInConfig()
			if err != nil {{
				panic(errors.New("failed to load config file"))
			}}

			err = viper.Unmarshal(&Config)
			if err != nil {{
				panic(errors.New("failed to save config"))
			}}

			return nil
		}}

		func InitLogger() (err error) {{
			LogFile, err = os.OpenFile(Config.LogFile, os.O_WRONLY|os.O_APPEND, os.ModePerm)
			if err != nil {{
				panic(errors.New("failed to open logfile"))
			}}

			fileWriter := zerolog.New(LogFile).With().Logger()
			multiOutputWriter := zerolog.MultiLevelWriter(os.Stdout, fileWriter)
			Logger = zerolog.New(multiOutputWriter).With().Timestamp().Logger()
			return nil
			}}
	]]    ,
      {
        i(1, "config file path"),
        i(2, "config file name"),
        c(3, {
          t "toml",
          t "yaml",
          t "json",
          t "env",
          t "xml",
        }),
        i(4, "env_vars"),
        rep(4),
      }
    )
  ),

  -- -- echo
  s(
    {
      name = "echo-function",
      trig = "efn",
      dscr = "echo function declaration",
    },
    fmt(
      [[
		func {1}(ctx echo.Context) error {{
			{2}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "/* code */"),
      }
    )
  ),

  -- -- blockchain
  s(
    {
      name = "blockchain-account-key",
      trig = "bc-ak",
      dscr = "create new private/public keys for a new account",
    },
    fmt(
      [[
		privateKeyECDSA, err := crypto.GenerateKey(),
		if err != nil {{
			fmt.Println(err)
		}}
		privateKeyBytes := crypto.FromECDSA(privateKeyECDSA),
		privateKeyEncoded := hexutil.Encode(privateKeyBytes),
		publicKey := privateKeyECDSA.Public(),
		publicKeyECDSA, ok := publicKey.(*ecdsa.PublicKey),
		if !ok {{
			fmt.Println(err)
		}}
		publicKeyBytes := crypto.FromECDSAPub(publicKeyECDSA),
		publicAddress := crypto.PubkeyToAddress(*publicKeyECDSA)
	]]    ,
      {}
    )
  ),

  s(
    {
      name = "blockchain-account-keystore-new",
      trig = "bc-aks",
      dscr = "create a new keystore",
    },
    fmt(
      [[
		ks := keystore.NewKeyStore({1},keystore.StandardScryptN,keystore.StandardScryptP)
		account,err := ks.NewAccount({2})
		if err != nil {{
			fmt.Println(err)
		}}
	]]    ,
      {
        i(1, "path"),
        i(2, "password"),
      }
    )
  ),

  s(
    {
      name = "blockchain-account-keystore-import",
      trig = "bc-aksi",
      dscr = "keystore import",
    },
    fmt(
      [[
		file := {1}
		jsonBytes,err := ioutil.ReadFile(file),
		account,err := ks.Import(jsonBytes,password,password),
		if err != nil {{
			fmt.Println(err)
		}}
	]]    ,
      {
        i(1, "file"),
      }
    )
  ),

  s(
    {
      name = "blockchain-address-valid",
      trig = "bc-ai",
      dscr = "determine if an account address is a valid",
    },
    fmt(
      [[
		validAddress := ethutil.IsValidAddress({})
	]]    ,
      {
        i(1, "address"),
      }
    )
  ),

  -- s({
  -- 	name = "blockchain-transaction-new",
  -- 	trig = "bc-txn",
  -- 	dscr = "create a new transaction",
  -- },
  -- 	fmt([[
  -- 		balance, err = client.BalanceAt(context.WithTimeout({2}), fromAddress , nil)
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		if balance < amount {{
  -- 			panic("insuficient founds")
  -- 		}}
  --
  -- 		privateKey, err := crypto.HexToECDSA({1})
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		nonce, err = client.PendingNonceAt(context.WithTimeout({3}), toAddress)
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		gasPrice, err = client.SuggestGasPrice(context.WithTimeout({4}))
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		gasLimit, err = client.EstimateGas(context.WithTimeout({5}),ethereum.CallMsg{{
  -- 			To: &tokenAddress,
  -- 			Data: data,
  -- 		}}),
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		chainID, err = client.NetworkID(context.WithTimeout({6}))
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		tx := types.NewTransaction(nonce, toAddres, amount, gasLimit, gasPrice, nil)
  -- 		signTx, err = types.SignTx(tx, types.NewEIP155Signer(chainID), privateKey)
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  --
  -- 		err = client.SendTransaction(context.WithTimeout({7}), signTx)
  -- 		if err != nil {{
  -- 			fmt.Println(err)
  -- 		}}
  -- -- ]],{
  -- 	i(1,"privateKey"),
  -- 	i(2,"timeout"),
  -- 	rep(2),
  -- 	rep(2),
  -- 	rep(2),
  -- 	rep(2),
  -- 	rep(2),
  -- }),

  s(
    {
      name = "blockchain-transaction-raw-new",
      trig = "bc-txnr",
      dscr = "create new raw transaction",
    },
    fmt(
      [[
		tx := types.NewTransaction(nonce,toAddress,amount,gasLimit,gasPrice,data)
		signedTx,err := types.SignTx(tx,types.NewEIP155Signer(chainID),privateKey)
		if err != nil {{
			log.Fatal(err)
		}}

		rawSignedTx := types.Transactions{{signedTx}}.GetRlp(0)
		rawTxHex := hex.EncodeToString(rawSignedTx)
		tx := new(types.Transaction)
		rlp.DecodeBytes(rawTxBytes,&tx)
		err = client.SendTrasaction(context.Background(),tx)
		if err != nil {{
			log.Fatal(err)
		}}
	]]    ,
      {}
    )
  ),
  s(
    {
      name = "blockchain-transaction-query-header",
      trig = "bc-txqh",
      dscr = "determine if a account is a smart contract",
    },
    fmt(
      [[
		header,err := client.HeaderByNumber(context.Background(),{1})
		if err != nil {{
			{2}
		}}
	]]    ,
      {
        i(1, "blockNumber"),
        i(2, "error handling"),
      }
    )
  ),

  s(
    {
      name = "blockchain-transaction-query-block",
      trig = "bc-txqb",
      dscr = "get block by number from blockchain",
    },
    fmt(
      [[
    	block,err := client.BlockByNumber(context.Background(),{1})
    	if err != nil {{
			{2}	
    	}}
	]]    ,
      {
        i(1, "blockNumber"),
        i(2, "error handling"),
      }
    )
  ),

  s(
    {
      name = "blockchain-transaction-count",
      trig = "bc-txq",
      dscr = "get number of transactions in a block",
    },
    fmt(
      [[
		block,err := client.TransactionCount(context.Background(),{1})
		if err != nil {{
			{2}	
		}}
	]]    ,
      {
        i(1, "blockHash"),
        i(2, "error handling"),
      }
    )
  ),

  s(
    {
      name = "blockchain-transaction-receipt",
      trig = "bc-txq",
      dscr = "get transaction receipt",
    },
    fmt(
      [[
		block,err := client.TransactionReceipt(context.Background(),{1})
		if err != nil {{
			{2}
		}}
	]]    ,
      {
        i(1, "txHash"),
        i(2, "error handling"),
      }
    )
  ),

  s(
    {
      name = "blockchain-transaction-signature",
      trig = "bc-txs",
      dscr = "generate a new signature",
    },
    fmt(
      [[
		privateKey,err := crypto.HexToECDSA({1})
		if err != nil {{
			fmt.Println(err)
		}}

		data = []byte({2})
		hash . crypto.Keccack256Hash(data)
		signature,err := crypto.Sign(hash.Bytes(),privateKey)
		if err != nil {{
			fmt.Println(err)
		}}
	]]    ,
      {
        i(2, "hex"),
        i(2, "data"),
      }
    )
  ),

  s(
    {
      name = "blockchain-token",
      trig = "bc-scc",
      dscr = "determine if a account is a smart contract",
    },
    fmt(
      [[
		fnSignature := []byte({1})
		hash := sha3.NewLegacyKeccak256().Write(fnSignature)
		methodID := hash.Sum(nil)[:4]
		toAddressPadded := common.LeftPadBytes(toAddress.Bytes(),32)
		amount := new(big.Int)
		amount.SetString({2})
		amountPadded := common.LeftPadBytes(amount.Bytes(),32)
		var data []byte
		data = append(data,methodID,toAddressPadded,amountPadded)
		gasLimit,err := client.EstimateGas(context.Background(),ethereum.CallMsg{{
			To: &tokenAddress,
			Data: data,
		}})
		if err != nil {{
			fmt.Println(err)
		}}
	]]    ,
      {
        i(1, "fnSignature"),
        i(2, "qty"),
      }
    )
  ),

  s(
    {
      name = "blockchain-smartcontract-is",
      trig = "bc-sci",
      dscr = "determine if a account is a smart contract",
    },
    fmt(
      [[
		bytecode,err := client.CodeAt(context.WithTimeout({1}),address,{2})
		if err != nil {{
			fmt.Println(err)
		}}
		isContract := len(bytecode) > 0
		}}
	]]    ,
      {
        i(1, "timeout"),
        i(2, "block"),
      }
    )
  ),

  -- s({
  -- 	name = "blockchain-smartcontract-new",
  -- 	trig = "bc-scn",
  -- 	dscr = "get log(events) of smart contracts",
  -- },fmt([[
  -- 	contractABI,err := abi.JSON(strings.NewReader(string({2},.{2}ABI))),
  -- 	if err != nil {{
  -- 		fmt.Println(err)
  -- 	}}
  -- ]],{
  -- 	i(1,"contract"),
  -- 	rep(1),
  -- }),

  s(
    {
      name = "blockchain-smartcontract-log-subscribe",
      trig = "bcscqs",
      dscr = "subscribe to log(events) of smart contracts",
    },
    fmt(
      [[
		contractAddress = {1}
		query := ethereum.FilterQuery {{
			Addresses: []common.Address{{contractAddress}}
			FromBlock: big.NewInt()
			ToBlock: big.NewInt()
		}}

		logs := make(chan types.Log)
		sub,err := client.SubscribeFilterLogs(context.Bakcground(),query,logs)
		if err != nil {{
			fmt.Println(err)
		}}

		for {{
			select {{
				case err := <-sub.Err() :
					fmt.Println(err)
				case eventLog := <-logs :
					if err != nil {{
						fmt.Println(err)
					}}
			}}
		}}
		
	]]    ,
      {
        i(1, "contractAddress"),
      }
    )
  ),

  s(
    {
      name = "blockchain-smartcontract-log-read",
      trig = "bcscq",
      dscr = "get log(events) of smart contracts",
    },
    fmt(
      [[
        contractAddress = {1}
        query := ethereum.FilterQuery {{
          Addresses: []common.Address{{contractAddress}}
          FromBlock: big.NewInt()
          ToBlock: big.NewInt()
        }}

        logs := client.FilterLogs(context.Background(),query)
        if err != nil {{
          fmt.Println(err)
        }}

        contractABI,err := abi.JSON(strings.NewReader(string({2},contractABI)))
        if err != nil {{
          fmt.Println(err)
        }}

        for _,eventLog := range Logs {{
            event := struct {{
              Key [32]byte,
              Value [32]byte,
            }}{{}}

            err := contractABI.Unpack(&event,\item set\,eventLog.Data)
            if err != nil {{
              fmt.Println(err)
            }}
            fmt.Println(string(event.Key[:]))
            fmt.Println(string(event.Value[:]))

            //const (
            //    EventFn1NameSign := crypto.Keccak256Hash([]byte(EventFn1Name))
            //    EventFn2NameSign := crypto.Keccak256Hash([]byte(EventFn2Name))
            //)
            //var topics []string
            //switch eventLog.Topics[0].Hex() {{
            //    case EventFn1NameSign.Hex()
            //
            //    case EventFn2NameSign.Hex() :
            //
            //}}
        }}
    ]] ,
      {
        i(1, "contract"),
        i(2, "contractAddress"),
      }
    )
  ),

  -- ------------------------------------------------------
  -- --     					patterns 				 	--
  -- ------------------------------------------------------
  s(
    {
      name = "pattern-worker",
      trig = "pattern-worker",
      dscr = "worker pattern",
    },
    fmt(
      [[
		func main() {{
			pending , done := make(chan *Task) , make(chan *Task)
			go sendWork(pending)
			for i := o ; i < N ; i++ {{
				go Worker(pending,done)
			}}
		}}

		func Worker(in,out chan *Task) {{
			for {{
				t := <- in
				process(t)
				out <- t
			}}
		}}
	]]    ,
      {}
    )
  ),
})
