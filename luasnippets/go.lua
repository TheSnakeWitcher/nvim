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
      name = "!",
      trig = "!",
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
	]]  ,
      {
        i(1, "name"),
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
        c(1, {
          sn(nil, {
            t('"'),
            i(1, "name"),
            t('"'),
          }),
          sn(nil, {
            t({'(','\t"'}),
            i(1, "names"),
            t({'"',')'}),
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

  --------------------------------------------------------
  --     				control structures   			--
  --------------------------------------------------------
  -- bifurcation
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
        i(2, "/* method set or constraint_type1 | constraint_type2 */"),
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

  -- viper
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

  -- echo
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

  ------------------------------------------------------
  --     					patterns 				 	--
  ------------------------------------------------------
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
