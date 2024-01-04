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
local fmta = require("luasnip.extras.fmt").fmta
local events = require "luasnip.util.events"
local conds = require "luasnip.extras.conditions"
local ai = require "luasnip.nodes.absolute_indexer"
local m = extras.match
local l = extras.lambda
local rep = extras.rep
local n = extras.nonempty
local postfix = require("luasnip.extras.postfix").postfix

-- common nodes

ls.add_snippets("solidity", {

  ------------------------------------------------------
  -- codebase structures
  ------------------------------------------------------
  s(
    {
      name = "structure",
      trig = "!",
      dscr = "declare solidity and abicoder version to be used",
    },
    fmt([[
      //SPDX-License-Identifier: MIT
      pragma solidity ^{} ;
      pragma {} ;


      {}
    ]],
      {
        d(1,function()
            local solc_version_cmd_out = vim.fn.system({"solc","--version"})
            local solc_version = string.match(solc_version_cmd_out,"%d.%d+.%d%d*")
            if solc_version then
                return sn(nil,{i(1,solc_version)})
            else
                return sn(nil,{i("version")})
            end
        end,{},{}),
        c(2, {
          t "abicoder v2",
          t "abicoder v1",
        }),
        i(3,"/* code */"),
      }
    )
  ),

  s(
    {
      name = "import",
      trig = "im",
      dscr = "import external package,note: can be a paht or a url",
    },
    fmt([[
	  import {}
	]]  ,
      {
        c(1, {
          sn(nil, fmt([[
            "{}" ;
          ]], {
            i(1, "package"),
          })),
          sn(nil, fmt([[
            {{ {} }} from "{}" ;
          ]], {
            i(2, "object"),
            i(1, "package"),
          })),
        })
      }
    )
  ),

  -- comments
  s(
    {
      name = "comment",
      trig = "/**",
      dscr = "declare a comment block",
    },
    fmt([[
        /**
         * {}
         */
	]]  ,
      { i(1,"code") }
    )
  ),


  -- contracts
  s(
    {
      name = "contract",
      trig = "ct",
      dscr = [[contract declaration,note:
        * constructor is only used during contract creation
        * contract is abstract when at least one of their functions isn't
          implemented or may be marked as abstract
          implement abstract functions in derived contracts must have the override keyword
        * inheritance is ordered from most base(lefth) to most specialized or derived(rigth)
        * constructor are always called in this order
      ]],
    },
    fmt([[
      /**
       * @title {title}
       */
      contract {name} {parent}{{

        {}

      }}
    ]],
      {
        title = rep(1),
        -- name = i(1,"name"),
        name = d(1,function()
            local file = vim.fn.expand("%:t:r")
            return sn(nil,{ i(1,file) })
        end,{},{}),
        parent = c(2, {
          sn(nil, fmt([[
            is {} 
          ]], {
            i(1, "basecontract"),
          })),
          t("")
        }),
        c(3, {
          sn(nil, fmt([[
            constructor({1}) {2} {{
              {3}
            }}

            {4}
          ]], {
            c(1, {
              i(1, "_args"),
              t(""),
            }),
            c(2, {
              i(1, "constraints"),
              t(""),
            }),
            i(3, "/* code */"),
            i(4, "/* code */"),
          })),
          i(1, "/* code */"),
        }),
      }
    )
  ),

  s(
    {
      name = "contract-test",
      trig = "ctt",
      dscr = [[ ]],
    },
    fmt([[
        // SPDX-License-Identifier: UNLICENSED
        pragma solidity {solc} ;

        import "../lib/forge-std/src/Test.sol" ;
        import "./TestUtil.t.sol" ;

        contract {contract}Test is Test , TestUtil {{

            {contract} testContract ;

            function setUp() public {{
                testContract = new {contract}({}) ;
            }}

            {}

        }}
    ]],
      {
        solc = f(function()
            local solc_version_cmd_out = vim.fn.system({"solc","--version"})
            local solc_version = string.match(solc_version_cmd_out,"%d.%d+.%d%d*")
            if solc_version then
                return solc_version
            else
                return "version"
            end
        end,{},{}),
        contract = f(function()
            local filename = vim.fn.expand("%:t")
            local extension = ".t.sol"
            return string.gsub(filename, extension, "")
        end, {}, {}),
        i(1, "args"),
        i(2, "/* code */"),
      }
    )
  ),

  -- library
  s(
    {
      name = "using",
      trig = "using",
      dscr = [[using library statement,notes:
        Libraries are contracts that are deployed only once at specific
        address(singlestons with read-only functions) and their code is
        reused using DELEGATECALL and CALLCODE

        * deployed/linked librarys have public or external functions
        * embedded librarys have only internal functions and are included in the contract that use it
        Libraries are a special form of contracts that:
            * Are singletons
            * Not allowed any storage or state variables that change
            * Cannot have fallback functions
            * Have no event logs
            * Do not hold Ether
            * Are stateless
            * Cannot use destroy
            * Cannot inherit or be inherited
      ]],
    },
    fmt([[
        using {1} for {2} ;
    ]]  ,
      {
        i(1, "`{lib}` / `{lib} as {alias}` / `{lib} as {+} global`"),
        c(2, {
            i(1,"type "),
            sn(1,{
                i(1,"type"),
                t(" global"),
            }),
        }),
      }
    )
  ),

  s(
    {
      name = "library",
      trig = "library",
      dscr = [[ library declaration,note:
        * can't declare state variables or send ether
		* a library is embedded into the contract if all library functions are
		  internal otherwise library must be deployed and then linked before the
		  contract is deployed
	]]    ,
    },
    fmt([[
      library {1} {{
	    {2}	
      }}
    ]],
      {
        i(1, "name"),
        i(2, "/* code */"),
      }
    )
  ),

  -- interfaces
  s(
    {
      name = "interface",
      trig = "interface",
      dscr = [[interface declaration,note:
        * all functions declarations must be external and are implicitly virtual
        * all functions declarations cannot have implementations
        * cannot inherith from contract but can from other interfaces
        * cannot declare constructor/state variables/modifiers but can declare types like structs or enums
      ]],
    },
    fmt([[
        interface {1} {{
            {2}	
        }}
    ]]  ,
      {
        i(1, "name"),
        i(2, "/* function signature set, events*/"),
      }
    )
  ),

  s(
    {
      name = "interface-use",
      trig = "interface",
      dscr = "interface usage",
    },
    fmt([[
	  {} {} = {}({}) ;
	]]  ,
      {
        i(1, "interface_type"),
        i(2, "interface_name"),
        rep(1),
        i(3, "contract_address")
      }
    )
  ),

  -- functions
  s(
    {
      name = "function",
      trig = "fn",
      dscr = [[function declaration,note
		functions visibility:
		    * private: only can be see/used by current contract, private funcitons aren't part of ABI
		    * public: everybody can see/used function,
		    * internal: only can be see/used by current contracts and childs, internal functions aren't part of ABI
		    * external: only can be see/used by EOA(external owned accounts) 
		functions constraints/state mutability:
		    * pure: not read/write
		    * view: rea donly
		    * payable: can receive ether
		    * virtual: can be override by childs contracts, not is mutually exclusive with override
		    * override: override a virtual functions of some parent contract, not is mutually exclusive with virtual
	]],
    },
    fmt([[
        function {1}({2}) {4} {5}{3}{{
            {6}
        }}
    ]]  ,
      {
        i(1, "name"),
        c(2, {
          i(1,"_args"),
          t "",
        }),
        c(3,{
            fmt("returns ({}) ",{ i(1, "types") }),
            t "",
        }),
        c(4,{
            t("private"),
            t("public"),
            t("internal"),
            t("external"),
        }),
        c(5,{
            t(""),
            sn(1,{ t("view "), i(1) }),
            sn(1,{ t("pure "), i(1) }),
            sn(1,{ t("virtual "), i(1) }),
            sn(1,{ t("override "), i(1) }),
            sn(1,{ t("payable "), i(1) }),
        }),
        i(6,"/* code */"),
      }
    )
  ),

  s(
    {
      name = "function test",
      trig = "fnt",
      dscr = "function test declaration",
    },
    fmt([[
      function {}({}) public {{
        {}
      }}
	]]  ,
      {
        c(1, {
            sn(nil,{
                t("test_"),
                i(1,"Name"),
            }),
            sn(nil,{
                t("testFail_"),
                i(1,"Name"),
            }),
        }),
        c(2, {
          i(1,"_args"),
          t "",
        }),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "function-interface",
      trig = "fni",
      dscr = "function declaration inside an interface",
    },
    fmt([[
      function {1}({2}) external virtual {3}{{
        {4}
      }}
	]]  ,
      {
        i(1, "name"),
        c(2, {
          t "_args",
          t "",
        }),
        c(3, {
          i(1,"constraint"),
          t "",
        }),
        i(4, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "modifier",
      trig = "modifier",
      dscr = [[create a modifier, note:
        * modifier are used to validate that condition are meet in functions
        * _ is only used in modifiers & mean "execute rest of the code"
      ]],
    },
    fmt(
      [[
		modifier {1}({2}) {{
			{3}
			_ ;
			{4}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "_args"),
        c(3, {
          i(1, "/* require,revert,assert */"),
          t "",
        }),
        c(4, {
          i(1, "/* require,revert,assert */"),
          t "",
        }),
      }
    )
  ),

  s(
    {
      name = "require",
      trig = "require",
      dscr = [[
        require: validate that condition is meet,otherwise return msg/error,note: modifier cannot have same name as a function
        revert: revert unconditionally aborts and revert all change,note: modifier cannot have same name as a function
        assert: assert that cond is hold,note: modifier cannot have same name as a function
      ]],
    },
    fmt([[
	    {}
	]]  ,
      {
        c(1, {
          sn(nil, fmt([[
            if ( {} ) revert {} ;
          ]], {
            i(1,"condition"),
            i(2,"ErrorName"),
          })),
          sn(nil, fmt([[
            require({1},"{2}") ;
          ]], {
            i(1, "condition"),
            i(2, "msg/error"),
          })),
          sn(nil, fmt([[
		    assert({1}) ;
          ]], {
            i(1, "cond"),
          })),
        })
      }
    )
  ),

  ------------------------------------------------------
  -- control structures
  ------------------------------------------------------

  -- branching/bifurcation
  s(
    {
      name = "if",
      trig = "if",
      dscr = "if declaration",
    },
    fmt(
      [[
		if ({1}) {{
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
      name = "ife",
      trig = "ife",
      dscr = "if/else declaration",
    },
    fmt([[
      if ({1}) {{
        {2}
      }} else {{
        {3}
      }}
	]]  ,
      {
        i(1, "cond"),
        i(2, "/* code */"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "ift",
      trig = "ift",
      dscr = "if ternary declaration",
    },
    fmt([[
      {1} ? {2} : {3}
    ]],
      {
        i(1, "cond"),
        i(2, "val_if_true"),
        i(3, "val_if_false"),
      }
    )
  ),

  s(
    {
      name = "switch",
      trig = "switch",
      dscr = "switch eclaration",
    },
    fmt([[
      switch {}
        case {} {{
          {}
        }}
        case {} {{
          {}
        }}
    ]],
      {
        i(1, "expression"),
        i(2, "cond1"),
        i(3, "cond2"),
        i(4, "code1"),
        i(5, "code2"),
      }
    )
  ),
  -- loops
  s(
    {
      name = "for",
      trig = "for",
      dscr = "for loop declaration",
    },
    fmt(
      [[
		for(uint i = {1} ; i < {2} ; ++i ) {{
			{3}
		}}
	]]    ,
      {
        i(1, "iter"),
        i(2, "length"),
        i(3, "/* code */"),
      }
    )
  ),

  s(
    {
      name = "while",
      trig = "while",
      dscr = "while loop declaration",
    },
    fmt(
      [[
		while {1} {{
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
      name = "try",
      trig = "try",
      dscr = "can only catch errors from external functions calls and contract creation",
    },
    fmt([[
		try {1} {{
			{3} 
		}} catch {2} {{
			{4} 
		}}
	]]  ,
      {
        i(1, "cond"),
        i(2, "error"),
        i(3, "/* try code */},"),
        i(4, "/* catch code */,"),
      }
    )
  ),

  ------------------------------------------------------
  -- data structures
  ------------------------------------------------------
  s({
    name = "types",
    trig = "types",
    dscr = "solidity types",
  }, {
    c(1, {
      t "ether",
      t "wei",
      t "address",
      t "bool",
      t "string",
      sn(1, {
        t "bytes",
        i(1, "N"),
      }),
      sn(1, {
        t "uint",
        c(1, {
          t "",
          t "8",
          t "16",
          t "32",
          t "64",
          t "128",
          t "256",
        }),
      }),
      sn(1, {
        t "int",
        c(1, {
          t "",
          t "8",
          t "16",
          t "32",
          t "64",
          t "128",
          t "256",
        }),
      }),
    }),
  }),

  s({
    name = "type",
    trig = "type",
    dscr = [[type declaration statement,note:
        declare a new type `newtype` that is different
        from `underlying_type` but can be asigned with
        values of same type
    ]],
  },fmt([[
    type {} is {} ;
  ]],{
    i(1,"newtype"),
    i(2,"underlying_type"),
  })),

  s(
    {
      name = "constant",
      trig = "const",
      dscr = "constant declaration",
    },
    fmt(
      [[
		{1} {2} {3} {4} = {5} ;
	]]    ,
      {
        i(1, "type"),
        c(2,{
            t("private"),
            t("public"),
            t("internal"),
        }),
        c(3, {
          t "constant",
          t "inmutable",
        }),
        i(4, "name"),
        i(5, "value"),
      }
    )
  ),

  s(
    {
      name = "variable",
      trig = "var",
      dscr = [[variable declaration,notes:
        * state varialbes default visibility is private
        * data is storage sequentially in order of declaration
          var space are in slots(start from 0 to 2**256 slots of 32 bytes) if
          neighboring varialbes fit in a single 32 bytes slot they are packed togueter
        * storage is saved on blockchain(pass by reference)
        * memory are living during function call(pass by value)
        * calldata is for external function arguments only
        * inmutable are variables only seted in constructor
      ]],
    },
    fmt(
      [[
		{1} {2} {3} = {4} ;
	]],
      {
        i(1, "type"),
        i(2, "varc"),
        c(3, {
          t "storage",
          t "memory",
          t "private",
          t "public",
          t "inmutable",
          t "calldata",
          t "payable",
        }),
        i(4,"value"),
      })
  ),

  s({
      name = "arr",
      trig = "arr",
      dscr = "array declaration",
    },
    fmt(
      [[
		{1}[{2}] {3} {4} ;
	]]    ,
      {
        i(1, "type"),
        i(2, "length"),
        c(3, {
          t "storage",
          t "memory",
          t "private",
          t "inmutable",
          t "public",
          t "calldata",
          t "payable",
        }),
        i(4, "name"),
      }
    )
  ),

  s({
    name = "arr-fn",
    trig = "arrfn",
    dscr = "array function",
  }, {
    c(1, {
      t "arr.push()",
      t "arr.pop()",
      t "arr.length",
      t "delete arr[i]",
    }),
  }),

  s(
    {
      name = "map",
      trig = "map",
      dscr = "map declaration",
    },
    fmt(
      [[
		mapping({1} => {2}) {3} {4} ;
	]]    ,
      {
        i(1, "keyType"),
        i(2, "valType"),
        i(3, "constraint"),
        i(4, "name"),
      }
    )
  ),

  s(
    {
      name = "enum",
      trig = "enum",
      dscr = "enum declaration",
    },
    fmt(
      [[
        /**
         *
         */
		enum {1} {{
			{2},
			{3}
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "variant1"),
        i(3, "variant2"),
      }
    )
  ),

  s(
    {
      name = "struct",
      trig = "struct",
      dscr = "struct declaration",
    },
    fmt(
      [[
        /**
         * @member
         */
		struct {1} {{
			{2} ;
		}}
	]]    ,
      {
        i(1, "name"),
        i(2, "fields"),
      }
    )
  ),

  s(
    {
      name = "error",
      trig = "error",
      dscr = "error declaration",
    },
    fmt([[
      error {1}({2}) ;
	]]  ,
      {
        i(1, "name"),
        i(2, "fields"),
      }
    )
  ),

  s(
    {
      name = "event-declaration",
      trig = "event",
      dscr = [[ event declaration,note: 
            indexed keyword can be used in events wich adds them to a
            special data structure known as "topics"(wich have 32 bytes)
            instead of part of the logs,up to 3 params can be indexed
            
            event can be declared like anonimous event(parameters) wich
            are cheaper to deploy and call but can't be acceses by event
            name and can only be accesed by their associated contract address
            and not by name
      ]],
    },
    fmt([[
	    event {}({}) {} ; /// @notice emitted when {}
	]],
      {
        i(1, "name"),
        i(3, "type [indexed] fields"),
        c(2,{
            t("anonymous "),
            t(""),
        }),
        i(4,"trigger"),
      }
    )
  ),

  s(
    {
      name = "event-emit",
      trig = "emit",
      dscr = "event emition",
    },
    fmt(
      [[
		emit {1}({2}) ;
	]]    ,
      {

        i(1, "event"),
        i(2, "data"),
      }
    )
  ),

  ------------------------------------------------------
  -- utilities
  ------------------------------------------------------
  s({
    name = "util-pkg",
    trig = "pkg",
    dscr = "list of commonly used packages",
  }, {
    c(1, {
      t "SafeMath",
      t "SafeMath2",
    }),
  }),

  s({
    name = "environment-variables",
    trig = "env",
    dscr = "global environment variables",
  }, {
    c(1, {
      t "this",
      t "msg.sender",
      t "msg.value",
      t "msg.data",
      t "msg.sig",
      t "block.coinbase",
      t "block.prevrandao",
      t "block.gaslimit",
      t "block.number",
      t "block.timestamp",
      t "blockhash(blocknumber)",
      t "tx.gasprice",
      t "tx.origin",
      t "addres(this).balance",
    }),
  }),

  s({
    name = "util-send",
    trig = "util-send",
    dscr = [[functions to send ether,note:
      call(forward all gas or set gas,return bool),this is the recomended method to use when send ether but not to call external functions
      transfer(2300 gas,trow error),
      send(2300 gas,trow error),
    ]],
  }, {
    c(1, {
      t '(bool sent ; bytes memory data) = _to.staticcall',
      t '(bool sent ; bytes memory data) = _to.call{value: msg.value,gas: gasAmount}("")',
      t "to.transfer(msg.value)",
      t "_to.send(msg.value)}",
    }),
  }),

  s({
    name = "util-receive",
    trig = "util-receive",
    dscr = [[function to receive ether,note:
      receive is called if msg.data is empty,
      otherwise or when a function that not exist is called fallback() is called,
      call with re-entrancy guard is the recomendation
    ]],
  }, {
    c(1, {
      t "receive() external payable{}",
      t "fallback() external payable",
    }),
  }),

  s({
    name = "util-hash",
    trig = "util-hash",
    dscr = [[solidity hashing function,note:
      * except keccak256 all other call external contracts
      * ecrecover validate that incoming data is properly signed by an expected party(verify tx signature)

    ]],
  }, {
    c(1, {
      t "keccak256(abi.encodePacked(data)) ;",
      t "sha256() ;",
      t "ripemd160() ;",
      t "ecrecover() ;",
      t "1addmod() ;",
      t "mulmod",
    }),
  }),

  s({
    name = "util-abi",
    trig = "util-abi",
    dscr = [[abi functions,note:
      * encodePacked returns byte array
    ]],
  }, {
    c(1, {
      sn(nil, fmt([[
        abi.encodePacked({}) ;
      ]], {
        i(1, "data1,data2"),
      })),
      sn(nil, fmt([[
        abi.encode({}) ;
      ]], {
        i(1, "data"),
      })),
      sn(nil, fmt([[
        abi.decode({},({})) ;
      ]], {
        i(1, "encodedData"),
        i(2, "typeListToDecode"),
      })),
      sn(nil, fmt([[
        abi.EncodeWithSignature({1},{2}) ;
      ]], {
        i(1, "fnSignatureString"),
        i(2, "PassedArgs"),
      })),
    }),
  }),

  s({
    name = "util-functions",
    trig = "util-fn",
    dscr = [[important functions,note:
      * unchecked perform operations without underflow/overflow verification
      * assembly allow to write assembly code
      * new keyword creates new instance of a contract by deploying contract & initializing its state variables and running its constructor,settign nonce to 1
    ]],
  }, {
    c(1, {
      sn(nil, fmt([[
        unchecked {{ {} }}
      ]], {
        i(1, "unchecked_code")
      })),
      sn(nil,fmt([[
        new {}
      ]],{
        i(1,"contract")
      })),
      t("super().{1}"),
    }),
  }),

  s({
    name = "util-assembly-block",
    trig = "asm-block",
    dscr = [[important functions,note:
      assembly allow to write assembly code inside block,
      this block is an isolated scope(variables are not shared between scopes)
    ]],
  }, fmt([[
    assembly {{
      {}
    }}
  ]], {
    i(1, "assembly_code")
  })),

  s({
    name = "aux-assembly",
    trig = "asm-block",
    dscr = [[important functions,note:
      * assembly allow to write assembly code inside block,
        this block is an isolated scope(variables are not shared between scopes)
      * extcodesize return legth of code in address
      * mload to load data(32 bytes) from memory
      * mstore to save data in memory
      * let declare a stack variable
      * pop delete a stack variable
      * 0x40(free memory pointer) and reserved memory
    ]],
  }, {
    c(1, {
      sn(nil, fmt([[ size = extcodesize({}) ]], { i(1, "account") })),
      sn(nil, fmt([[ let {} := {} ]], { i(1, "var"), i(2, "val"), })),
      -- mem
      sn(nil, fmt([[ mload({}) ]], { i(1, "memory_position"), })),
      sn(nil, fmt([[ mstore({},{}) ]], { i(1, "memory_position"), i(2, "data") })),
      sn(nil, fmt([[ mstore8({},{}) ]], { i(1, "memory_position"), i(2, "data") })),
      sn(nil, fmt([[ msize({}) ]], { i(1, "memory_position"), })),
      sn(nil, fmt([[ pop({}) ]], { i(1, "var"), })),
      sn(nil, fmt([[ push1({}) ]], { i(1, "var"), })),
      sn(nil, fmt([[ offset({}) ]], { i(1, "var"), })),
      sn(nil, fmt([[ sload({}) ]], { i(1, "memory_position"), })),
      sn(nil, fmt([[ sstore({},{}) ]], { i(1, "memory_position"), i(2, "data") })),
      -- arithmetic
      sn(nil, fmt([[ add({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ sub({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ mul({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ div({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ exp({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ mod({}) ]], { i(1, "vars"), })),
      -- logical
      sn(nil, fmt([[ not({}) ]], { i(1, "var"), })),
      sn(nil, fmt([[ and({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ or({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ xor({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ shl({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ shr({}) ]], { i(1, "vars"), })),
      sn(nil, fmt([[ sar({}) ]], { i(1, "vars"), })),
      -- comparison
      sn(nil, fmt([[ iszero({}) ]], { i(1, "var"), })),
      sn(nil, fmt([[ eq({},{}) ]], { i(1, "var1"), i(2, "var2"), })),
      sn(nil, fmt([[
        {}lt({})
      ]], {
        c(1, { t("s"), t(""), }),
        i(1, "var1"),
      })),
      sn(nil, fmt([[
        {}gt({})
      ]], {
        c(1, { t("s"), t(""), }),
        i(2, "var"),
      })),
      -- smart contract specific
      t("chainid()"), -- chainid of the executing chain(EIP-1344)
      t("basefee()"), -- current block's base fee(EIP-3198 & EIP-1559)
      t("origin()"), -- transaction sender
      t("gasprice()"), -- tx gas price
      sn(nil, fmt([[ blockhash({}) ]], { i(1, "number"), })),
      t("coinbase()"), -- current mining beneficiary
      t("timestamp()"), -- timestamp of current block in seconds since epoch
      t("number()"), -- current block number
      t("prevrandao()"), -- current block difficulty
      t("gaslimit()"), -- current block gas limit
      t("gas()"), -- current block gas still available to execution
      t("address()"), -- current block gas still available to execution
      sn(nil, fmt([[ balance({}) ]], { i(1, "address"), })), -- balance in wei of account
      t("selfbalance()"), -- equivalent to balance(address()) but cheaper
      t("caller()"), -- call sender excluding delegatecall
      t("callvalue()"), -- wei sent together with the current call
      sn(nil, fmt([[ calldataload({}) ]], { i(1, "position"), })), -- call data starting from position(32 bytes)
      t("callsize()"), -- size of call data in size
      sn(nil, fmt([[
        calldatacopy({},{},{})
      ]], {
        i(1, "t"),
        i(2, "f"),
        i(3, "s"),
      })), -- copy s bytes from calldata position at position f to mem at position t
      t("codesize()"), -- size of the code of the current contract/execution
      -- creating(deploying contracts)
      sn(nil, fmt([[
        create({},{},{})
      ]], {
        i(1, "v"),
        i(2, "p"),
        i(3, "n"),
      })), -- create new contract with code mem[p..(p+n)] and send v wei and return new address; returns 0 on error
      sn(nil, fmt([[
        create2({},{},{},{})
      ]], {
        i(1, "v"),
        i(2, "p"),
        i(3, "n"),
        i(4, "s"),
      })), -- create new contract with code mem[p..(p+n)] and send v wei and return new address; returns 0 on error
      sn(nil, fmt([[ return({},{}) ]], { i(1, "mem_address"), i(2, "bytes_number") })),
      t("stop()"), -- stop execution(equivalent to return(0,0))
    }),
  }),

  s({
    name = "util-notes",
    trig = "notes",
    dscr = "important notes about",
  }, {
    t {
      "view functions don't cost any gas when are called externally",
      "view functions called inside a child contract inside another functions wich is not view cost gas",
      "modifiers cannot have same name as a function",
      'Inheritance must be ordered from "most base-like" to “most derived',
      "Inherited methods(super().method()) from parents are called starting from rigth(more specialized) to left(more general)",
      "Interface functions can be overrided in derived contract,but overrided functions in child must be declared virtual in order to be overrided again in contracts derived from child",
    },
  }),

})
