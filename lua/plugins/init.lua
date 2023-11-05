-- TODO: move cmds/autocmds to after/
-- TODO: enable spell in specific filetypes and comments
-- TODO: search where is seted <leader>D definition keymap and remove it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function load_config(module)
    local ok, module_config = pcall(require, "plugins." .. module)
    if not ok then
        vim.notify(module .. " config not loaded")
        return {}
    end
    return module_config
end


--- @PluginList https://dotfyle.com/
--- @PluginList https://github.com/yutkat/my-neovim-pluginlist
--- @PluginList https://github.com/rockerBOO/awesome-neovim.git
require("lazy").setup({
    ----------------------------------------------------------------
    ---- base
    ----------------------------------------------------------------
    { "nvim-lua/plenary.nvim" },    -- usefull collection of lua functions for neovim
    { "nvim-lua/popup.nvim" },      -- popup api implementation of vim for neovim
    { "ray-x/guihua.lua" },         -- GUI library
    { "MunifTanjim/nui.nvim" },     -- UI component library
    { "folke/neodev.nvim" },        -- plugin development setup 
    -- tools management UI to easily install lsp,dap,linters,formatters,etc
    {
        "williamboman/mason.nvim",
        priority = 100,
        config = function() load_config("mason") end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- bridge mason with lspconfig
            "jayp0521/mason-null-ls.nvim",       -- bridge mason with null-ls
            "jay-babu/mason-nvim-dap.nvim",      -- bridge mason with nvim-dap
        },
    },
    -- network resource manager
    {
        "miversen33/netman.nvim",
        opts = { sources = { "filesystem", "netman.ui.neo-tree" } }
        -- config = function() load_config("netman") end,
    },
    -- base improvement plugins
    --use {
    --    "echasnovski/mini.nvim",
    --    opt = true,
    --}


    --------------------------------------------------------------
    -- ui
    --------------------------------------------------------------
    -- colorschemes
    { "romgrk/doom-one.vim" , priority = 1000 , init = function() vim.cmd("colorscheme doom-one") end },
    { "folke/tokyonight.nvim" , lazy = true },
    { "Mofiqul/dracula.nvim" , lazy = true },
    -- icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function() load_config("nvim-web-devicons") end,
    },
    -- file explorer
    {
        -- check https://github.com/elihunter173/dirbuf.nvim
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = function() load_config("neo-tree") end,
    },
    -- statusline (bottom bar)
    {
        "nvim-lualine/lualine.nvim",
        config = function() load_config("lualine") end,
    },
    -- tabline (top bar)
    {
        "nanozuki/tabby.nvim",
        config = function() load_config("tabby") end,
    },
    -- lsp symbols top bar
    {
       "glepnir/lspsaga.nvim",
       config = function() load_config("lspsaga") end,
    },
    -- startup screen/dashboard
    {
       "glepnir/dashboard-nvim",
       config = function() load_config("dashboard") end,
    },
    -- improve input interfaces (vim.ui.input & vim.ui.select)
    {
        "stevearc/dressing.nvim",
        config = function() load_config("dressing") end,
    },
    -- improve notifications(vim.notify)
    {
        "rcarriga/nvim-notify",
        priority = 1000,
        config = function() load_config("nvim-notify") end,
        init = function() vim.notify = require('notify') end,
    },
    -- cursorline (highligh all word in buffer equals to word under cursor)
    {
        "yamatsum/nvim-cursorline",
        config = function() load_config("nvim-cursorline") end,
    },
    -- highlight, list and search notes(todo-comments)
    {
        "folke/todo-comments.nvim",
        config = function() load_config("todo-comments") end,
    },
    -- easily add highlight to comments with @{highlight}
    {
        "folke/paint.nvim",
        config = function() load_config("paint") end,
    },
    { "itchyny/vim-highlighturl" }, -- highlighturl urls in buffer
    -- colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function() load_config("colorizer") end,
    },
    -- fold signs
    {
        "yaocccc/nvim-foldsign",
        config = function() load_config("nvim-foldsign") end,
    },
    -- vscode like icons for completion menu
    { "onsails/lspkind.nvim" },
    -- animated signs
    -- use {
    --     "ElPiloto/significant.nvim",
    --     config = function() load_config("significant") end,
    -- }
    -- use "VonHeikemen/fine-cmdline.nvim" -- enhaced cmdline


    ----------------------------------------------------------------
    ---- treesiter
    ----------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        config = function() load_config("nvim-treesitter") end,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-context",     -- show code context
            "JoosepAlviste/nvim-ts-context-commentstring", -- to embeded languaje trees jsx/tsx
            "nvim-treesitter/nvim-treesitter-textobjects", -- additional text objects via treesitter
            "nvim-treesitter/nvim-tree-docs",              -- documentation
            -- "ibhagwan/ts-vimdoc.nvim",                  -- treesitter base markdown to vimdoc convertion tool
            --"RRethy/nvim-treesitter-textsubjects",
            --"p00f/nvim-ts-rainbow"                       -- highligh 
            --"windwp/nvim-ts-autotag"                     -- use treesitter to autocose & autorename html tags
            --"nfrid/treesitter-utils"
        }
    },


    ----------------------------------------------------------------
    ---- lsp
    ----------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim",
            -- view status updates/progress for LSP(view ops progress)
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
                config = function() load_config("fidget") end,
            },
            --  lsp signature hint as typing 
            {
                "ray-x/lsp_signature.nvim",
                config = function () load_config("lsp_signature")end,
            },
        },
        config = function() load_config("nvim-lspconfig") end,
    },
    -- bridge/hook up non-LSP tools to the LSP UX through lua
    -- use neovim as a language server to inject LSP diagnostics, code actions, and more via Lua. 
    {
        -- "mfussenegger/nvim-lint", -- async linter
        "nvimtools/none-ls.nvim",
        config = function() load_config("none-ls") end,
    },
    -- diagnostics
    {
        -- pretty diagnostics
        "folke/trouble.nvim",
        config = function() load_config("trouble") end,
    },
    -- use "https://git.sr.ht/~whynothugo/lsp_lines.nvim" -- renders diagnostics using virtual lines on top of the real line of code
    -- lsp navigation
    {
        "ray-x/navigator.lua",
        config = function() load_config("navigator") end,
    },
    --use {
    --    "RishabhRD/nvim-lsputils",
    --    requires = "RishabhRD/popfix",
    --}


    --------------------------------------------------------------
    -- search
    --------------------------------------------------------------
    -- fzf
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function() load_config("telescope") end,
        dependencies = {
            "LinArcX/telescope-env.nvim",                    -- search environment variables
            "nvim-telescope/telescope-file-browser.nvim",    -- search/manipulate filesystem
            "nvim-telescope/telescope-media-files.nvim",     -- search media files
            "LukasPietzschmann/telescope-tabs",              -- search tabs
            "crispgm/telescope-heading.nvim",                -- search headers
            "jvgrootveld/telescope-zoxide",
            {   -- create telescope pickers from shell commands
                "axkirillov/easypick.nvim",
                config = function() load_config("easypick") end,
            },
            {   -- use fzf
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            -- {
                    --config = function()
        	        --    require'telescope-tabs'.setup{
        		    --        -- Your custom config :^)
        	        --    }
                    --end
            -- }
            -- "nvim-telescope/telescope-cheat.nvim",  -- an attempt to recreate cheat.sh
            -- "sdushantha/fontpreview",               -- search fonts
        },
    },
    -- buffer and mark management
    {
        "j-morano/buffer_manager.nvim",
        config = function() load_config("buffer_manager") end,
    },
    -- project and session management
    {
        "GnikDroy/projections.nvim",
        branch = "pre_release",
        config = function() load_config("projections") end,
    },
    -- tree view for lsp symbols/tags(code outline )
    {
        "stevearc/aerial.nvim",
        config = function() load_config("aerial") end,
    },
    -- search unicode/emojis characters management
    {
        "ziontee113/icon-picker.nvim",
        config = function() load_config("icon-picker") end,
    },
    -- search urls in buffer
    {
        "axieax/urlview.nvim",
        config = function() load_config("urlview") end,
    },


    --------------------------------------------------------------
    -- completion
    --------------------------------------------------------------
    -- completion engine
    {
        "hrsh7th/nvim-cmp",
        config = function() load_config("nvim-cmp") end,
        dependencies = {
            "hrsh7th/cmp-buffer",                    -- buffers completion source
            "hrsh7th/cmp-path",                      -- paths completion source
            "hrsh7th/cmp-cmdline",                   -- cmdline completion source
            "hrsh7th/cmp-nvim-lua",                  -- neovim lua api completion source
            "hrsh7th/cmp-nvim-lsp",                  -- lsp completion source
            "saadparwaiz1/cmp_luasnip",              -- luasnip snippet engine completion source
            -- luasnip choice node completion source
            {
                "doxnit/cmp-luasnip-choice",
                -- opts = { auto_open = true },
            },
            "uga-rosa/cmp-dynamic",                  -- dynamic generation candidates sources
            "petertriho/cmp-git",                    -- git completion source
            "davidsierradz/cmp-conventionalcommits", -- conventional commtis
            "kdheepak/cmp-latex-symbols",            -- latex completion source
            "hrsh7th/cmp-calc",                      -- math calculation source
            -- github copilot source
            {
                "zbirenbaum/copilot-cmp",
                dependencies = "zbirenbaum/copilot.lua",
                config = function () require("copilot_cmp").setup() end
            }
            -- "tzachar/cmp-ai",                        -- ai completion source
            -- "hrsh7th/cmp-emoji",                  -- emoji completion source
        }
    },
    -- snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function() load_config("luasnip") end,
    },
    -- copilot source
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },


    --------------------------------------------------------------
    -- operational
    --------------------------------------------------------------
    -- highligh keybindings
    {
        "folke/which-key.nvim",
        config = function() load_config("which-key") end,
    },
    { "tpope/vim-repeat" },       -- make repeatable plugins operations
    -- surround operations on vim textobjects/symbols `"`,`()` ,`[]`,`{}`,`<>`,etc 
    { "tpope/vim-surround" },     -- check: https://github.com/kylechui/nvim-surround
    { "tpope/vim-speeddating" },  -- allow C-a/C-x to increment/decrement dates and times
    { "mbbill/undotree" },        -- save tree of undo operations
    { "unblevable/quick-scope" }, -- highligh unique chars per word in line(to use with `f`,`F`,`t`,`T`)
    -- to close automatically `(`,`[`,`"`,`'`
    {
        "windwp/nvim-autopairs",
        config = function() load_config("nvim-autopairs") end,
    },
    -- easily comment code(treesiter integration)
    {
        "numToStr/Comment.nvim",
        config = function() load_config("Comment") end,
    },
    { "sbulav/nredir.nvim" },       -- redirect outputs of commands and filters(external commands) to temp sidebuffer
    -- split/joint text blocks efficiently 
    {
        'Wansmer/treesj',
        keys = { '<leader>j' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() load_config('treesj') end,
    },

    --use "andymass/vim-matchup"           --  even better % fist_oncoming navigate and highlight matching words 
    -- code screenshots
    {
        "0oAstro/silicon.lua",
        config = function() load_config("silicon") end,
    },


    --------------------------------------------------------------
    -- test/dap
    --------------------------------------------------------------
    -- dap(debug adapter protocol) integration
    -- TODO: check use "kndndrj/nvim-projector" --  project-specific configs for nvim-dap with telescope
    {
        "mfussenegger/nvim-dap", -- alternative "puremourning/vimspector",
        config = function() load_config("nvim-dap") end,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
        },
    },
    -- tests runner/framework
    {
      "nvim-neotest/neotest",
      config = function() load_config("neotest") end,
      dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
        "neotest-foundry",
        "llllvvuu/neotest-foundry",
      },
    },


    --------------------------------------------------------------
    -- tools
    --------------------------------------------------------------
    -- custom submodes management (create custom submodes and menus)
    {
        "anuvyklack/hydra.nvim",
        config = function() load_config("hydra") end,
    },
    -- knowledgebase/notes management
    {
        "renerocksai/telekasten.nvim",
        config = function() load_config("telekasten") end,
    },
    {
        "Furkanzmc/zettelkasten.nvim",
        config = function() load_config("zettelkasten") end,
    },
    -- {
    --     -- utilities for markdown files navigation
    --     'jakewvincent/mkdnflow.nvim',
    --     config = function() load_config("mkdnflow") end
    -- },
    { "vimwiki/vimwiki" },  -- wiki management
    -- terminal management
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = function() load_config("toggleterm") end,
    },
    -- task/jobs management 
    {
        'stevearc/overseer.nvim',
        config = function() load_config("overseer") end,
    },
    -- use "GustavoKatel/tasks.nvim"
    {
        -- task management(vscode like task declared using json/yaml files)
        'jedrzejboczar/toggletasks.nvim',
        config = function() load_config("toggletasks") end,
    },
    -- http client
    {
        'rest-nvim/rest.nvim',
        config = function() load_config("rest") end,
    },
    -- previewiers
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow"
    },
    -- {
    --     -- markdow previewiers
    --     'toppair/peek.nvim',
    --     -- "iamcco/markdown-preview.nvim",
    --     cmd = 'deno task --quiet build:fast',
    --     config = function() load_config("peek") end,
    -- },
    --  image previewer
    -- {
    --     "edluffy/hologram.nvim",
    --     config = function() load_config("hologram") end,
    -- },
    -- database interaction management
    {
        "tpope/vim-dadbod",
        -- "tpope/vim-dadbodui",
        -- "tpope/vim-dadbod-completion",
        dependencies = { "kristijanhusak/vim-dadbod-ui" },
    },
    -- use {
    --     -- develop integration with overseer
    --     "kndndrj/nvim-dbee",
    -- }
    -- check
    -- https://github.com/stevearc/conform.nvim
    -- remote exploration
    {
        "sourcegraph/sg.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        build = "nvim -l build/init.lua", -- If you have a recent version of lazy.nvim, you don't need to add this!
    },

    --------------------------------------------------------------
    -- integrations
    --------------------------------------------------------------
    -- git
    { "tpope/vim-fugitive" }, -- git integration for cmdline
    {
        -- git integration for buffers
        "lewis6991/gitsigns.nvim",
        config = function() load_config("gitsigns") end,
    },
    { "sindrets/diffview.nvim" }, -- single tabpage interface for easily cycling through diffs for all modified files for any git rev
    -- single tabpage interface for easily view diffs
    -- use "kdheepak/lazygit.nvim"   -- open lazygit from neovim
    -- use "TimUntersberger/neogit"  -- git ui
    -- github
    {
        -- edit & review github issues
        "pwntester/octo.nvim",
        config = function() load_config("octo") end,
    },
    -- neovim plugin development with rust
    --use {
    --    "noib3/nvim-oxi",
    --    config = function() load_config("nvim-oxi") end,
    --}
    --use {
    --    "willothy/nvim-utils",
    --    config = function() load_config("nvim-utils") end,
    --}
    -- pandoc
    --use {
    --    -- latex like editing experience while writing markdown
    --    "abeleinin/papyrus",
    --    config = function() load_config("papyrus") end,
    --}


    ----------------------------------------------------------------
    ---- AI
    ----------------------------------------------------------------
    ---- use "aduros/ai.vim" -- generate and edit text using OpenAI and GPT. 
    ---- github copilot
    -- use {
    --     "zbirenbaum/copilot.lua",
    --     config = function() load_config("copilot") end,
    -- }
    ---- chatgpt
    --use {
    --    "jackMort/ChatGPT.nvim",
    --    cmd = "ChatGpt",
    --    config = function() load_config("chatgpt") end,
    --}
    ---- codeium ai toolkit integration
    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function() load_config("codeium") end,
    -- },
    ---- highlight and explain code readability issues
    ---- use {
    ----     "james1236/backseat.nvim",
    ----     config = function() load_config("backseat") end,
    ---- }


    ----------------------------------------------------------------
    ---- languaje specific
    ----------------------------------------------------------------
    ---- lua
    ----
    ---- rust
    -- {
    --     -- configure rust lsp
    --     "simrat39/rust-tools.nvim",
    --     config = function() load_config("rust-tools") end,
    -- },
    -- {
    --     'saecki/crates.nvim',
    --     -- tag = 'v0.3.0',
    --     event = { "BufRead Cargo.toml" },
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     config = function()
    --         require('crates').setup()
    --     end,
    -- }
    ---- go
    ----
    ---- latex
    -- "lervag/vimtex"
    ---- use "frabjous/knap"
    ---- conceal
    ---- use "KeitaNakamura/tex-conceal.vim"
    ---- use "Jxstxs/conceal.nvim"
    -- javascrtp/typescript
    -- package info
    -- {
    --    "vuki656/package-info.nvim",
    --    dependencies = "MunifTanjim/nui.nvim",
    --    config = function() load_config("package-info") end ,
    -- },


    ----------------------------------------------------------------
    ---- experimental 
    ----------------------------------------------------------------
    { "jbyuki/instant.nvim" },    -- collaborative coding,check https://github.com/Floobits/floobits-neovim
    ---- motions
    --use {
    --    -- motions for every coordinate of the viewport
    --    "ggandor/leap.nvim",
    --    opt = true,
    --    config = function() load_config("leap") end,
    --}

    ---- use "ai-phind" 

    ---- lsp
    ---- use "smjonas/inc-rename.nvim" -- incremental LSP renaming based on Neovim's command-preview feature.

    ---- markdown
    ---- use "SidOfc/mkdx" -- markdown utils

    ---- cmds
    --use "protex/better-digraphs.nvim"      -- better digraphs

    ---- tool for test interaction
    ---- use "tpope/vim-unimpaired",          -- complementary mapping
    ---- use "tpope/vim-sleuth"               -- detect tabstop and shiftwidth automatically
    ---- use "ThePrimeagen/refactoring.nvim"  -- refactoring tool
    ---- code runner
    --use {
    --    "michaelb/sniprun",
    --    opt = true,
    --    run = "bash ./install.sh",
    --    config = function() load_config("sniprun") end,
    --}
    ---- cloud
    --use { -- jupyter interaction
    --    'dccsillag/magma-nvim',
    --    opt = true,
    --    run = ':UpdateRemotePlugins',
    --    config = function()
    --        vim.g.magma_automatically_open_output = false
    --        vim.g.magma_image_provider = "ueberzug"
    --    end,
    --}
    ---- use "luk400/vim-jukit"     -- REPL interaction
    ---- use "Jxstxs/conceal.nvim"  -- conceal management

    ---- git integration
    --use {
    --    "sindrets/diffview.nvim",
    --    config = function() load_config("diffview") end,
    --}

    ---- github integration
    ---- use "Almo7aya/openingh.nvim"  -- open file or project in github for neovim wirtten in lua
    ---- use {
    --        -- open file or project in github for neovim wirtten in lua
    ----     "tjdevries/sg.nvim",
    ----     build = "cargo build --workspace",
    ---- }

    ----  containers integration
    ---- use {
    ----   'dgrbrady/nvim-docker',
    ----   rocks = '4O4/reactivex' -- ReactiveX Lua implementation
    ---- }
    ----  use "jamestthompson3/nvim-remote-containers"

    ---- completely replaces UI for messages, cmdline and the popupmenu
    ---- use "nvim-pack/nvim-spectre"   -- substitute content in various files
    ---- use "ap/vim-buftabline"        -- tabs management
    ---- use LintaoAmons/scratch.nvim"  -- open scratch buffers
    ---- use chrishrb/gx.nvim"          -- open urls in buffer

    ---- ui
    ----use {
    ----    "folke/noice.nvim",
    ----    config = function() load_config("noice") end,
    ----}
    ---- use "notomo/cmdbuf.nvim"      -- alternative cmdline
    ---- use "SmitheshP/nvim-navbuddy" -- pop up menu to navigate buffer lsp symbols

    ---- formater
    ---- use "cbochs/grapple.nvim" -- tagging import files and manage their
    ---- use "mhartington/formatter.nvim"  -- emmet integration

    ---- use "b0o/SchemaStore.nvim"  -- access to schemas from schemastore.org
    ---- remote development / collaboration
    ---- use "mhinz/neovim-remote"        -- support for --remote and fiends
    ---- use "chipsenkbeil/distant.nvim"  -- ALPHA STAGE: remote development from local environment 
    ---- NOTE: buffers per tabs
    ---- stackoverflow.com/questions/7595642/buffers-per-tab-in-vim
    ---- redis.com/r/neovim/comments/101f4w0/how_can_i_get_all_buffers_of_current_tab
    ---- vim.fn.tabpagebuflist() 
    ---- scope.nvim / tabby.nvim


    ----------------------------------------------------------------
    ---- development
    ----------------------------------------------------------------

    ---- foundry toolkit integration for web3 development
    ---- {
    ----      "TheSnakeWitcher/foundry.nvim",
    ----      config = function() load_config("foundry") end,
    ----      dependencies = { 
    --              "TheSnakeWitcher/cmp-web3-foundry.nvim",  -- completion source for foundry
    --        } 
    ---- },
    -- forge integration(foundry toolkit test framework)
    {
       dir = vim.g.plugin_dev_dir .. "/forge.nvim",
       config = function() load_config("forge") end,
    },
    -- chisel integration(REPL solidity from foundry toolkit)
    {
       dir = vim.g.plugin_dev_dir .. "/chisel.nvim",
       config = function() load_config("chisel") end,
    },
    -- anvil integration(local blockchain from foundry toolkit)
    {
       dir = vim.g.plugin_dev_dir .. "/anvil.nvim",
       config = function() load_config("anvil") end,
    },
    -- cast integration(foundry toolkit blockchain client inspired in rest.nvim and postman)
    -- {
    --     "TheSnakeWitcher/cast.nvim",
    --     config = function() load_config("cast") end,
    -- },


    ---- hardhat framework
    ---- provider hardhat command
    ---- use {
    ----      "TheSnakeWitcher/hardhat.nvim",
    ----      config = function() load_config("hardhat") end,
    ----      requires = {
    ----          "overseer-hardhat"  -- run hardhat task/scripts with overseer
    ----          "neotest-hardhat"   -- integrate hardhat/mocha test with neotest ? check neotest-js
    ----      }
    ---- }


    ---- integration with common web3 tools for dApp development
    ---- use {
    ----      "TheSnakeWitcher/web3tools.nvim", 
    ----      config = function() load_config("web3tools") end,
    ----      dependencies  = {
    ----            -- tool list: https://github.com/ConsenSys/ethereum-developer-tools-list
    ----            -- inline bookmarks by diligence
    ----            -- slither
    ----            -- mythril : https://github.com/dyng/eth-ramen
    ----            -- crypto address lens: https://marketplace.visualstudio.com/items?itemName=peetzweg.crypto-address-lens
    ----            -- ramen ui: https://github.com/dyng/eth-ramen
    ----            -- crytic-compile: https://github.com/crytic/crytic-compile/#crytic-compile
    ----            -- echidna: https://github.com/crytic/echidna
    ----            -- manticore: https://github.com/trailofbits/manticore/
    ----            -- brokentoken: https://github.com/zeroknots/brokentoken
    ----      }
    ---- }


    ---- utilities to aid in dAPP development process using autocmds/cmds/and others
    ---- use {
    ----      -- view what and from where data/methods are being inherited
    ----      -- detect automatically name clashes in inherit herarchy
    ----      -- detect automatically storage and function selector clashes in poxy-like contracts(pattern independent)
    ----      "TheSnakeWitcher/web3utils.nvim", 
    ----      config = function() load_config("web3utils") end,
    ---- }
    ---- use "TheSnakeWitcher/sourcify.nvim"         -- sourcify is a solidity source code and metadata verification tool
    ---- use "TheSnakeWitcher/openzeppelin-wizard"   -- openzeppelin bindings


    ---- utilities
    ---- use "multi-highlight.nvim"                  -- to highligh diferent visual selected text pieces
    ---- use "TheSnakeWitcher/tee.nvim"              -- analog to `tee` linux command for neovim to manage eficiently multiple input/ouput sources
    ---- use "TheSnakeWitcher/architect.nvim"        -- boilerplate/project init/scaffold structure management
    ---- use "TheSnakeWitcher/persistenfolds.nvim"   -- save folds in session
    ---- use "TheSnakeWitcher/doc-patterns.nvim"     -- get patterns in comments
    ---- use "TheSnakeWitcher/doc-hooks.nvim"        -- execute actions on patterns
    ---- use "TheSnakeWitcher/doc-traductions.nvim"  -- traduce documentation
    ---- use "TheSnakeWitcher/AIchat.nvim"           -- allow interaction/chat with AI tools
    ---- use {
    ----      "TheSnakeWitcher/tab_manager",
    ----      inspired = {
    ----          buffer_manager/harpoon
    ----          buffers per tab like scope
    ----          telescope integration like telescope-tabs
    ----          dbm/tabbot for window manager like experience
    ----      }
    ---- }

    ---- devops
    ---- use "TheSnakeWitcher/cmp-gh-actions"        -- completion source for github actions

    ---- knowledgebase management
    ---- use {
    ----      "TheSnakeWitcher/knowledgebase.nvim",
    ----      requires = {
    ----          "TheSnakeWitcher/zk.nvim",
    ----          "TheSnakeWitcher/wiki.nvim"
    ----      }
    ---- }
    ---- zetelkasten management
    ---- use {
    ----      "TheSnakeWitcher/zk.nvim",
    ----      check = {
    ----          https://github.com/oniony/TMSU
    ----      }
    ----      features = {
    ----          preview like obsidian or vim help files
    ----          tag pane plugin from obsidian
    ----          citations plugin
    ----          admonition plugin from obsidian
    ----          MOCs(maps of contents)
    ----      }
    ----      configuration = {
    ----          templates(select a template dir as configuration to make new_templated_note)
    ----      }
    ----      inspired = {
    ----          "renerocksai/telekasten.nvim"
    ----          "Furkanzmc/zettelkasten.nvim"
    ----          "jakewvincent/mkdnflow.nvim"
    ----      }    
    ----}
    ---- wiki management
    ---- use {
    ----     "TheSnakeWitcher/wiki.nvim"          -- wiki
    ----      inspired = {
    ----          "vimwiki/vimwiki"
    ----      }
    ---- }

})