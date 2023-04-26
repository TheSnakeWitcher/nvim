-- TODO: check why don't work projections autocmd in autocmds folders
-- TODO: enable spell in specific filetypes and comments
-- TODO: hot reload snippets automatically when changed
-- TODO: check dashboard/startup autocmd to be show when starting
-- TODO: use in plugins/init.lua util.load_config as load_config
local packer_boostraped = util.ensure_packer()
local packer = require("packer")

function load_config(module)
    local ok, module_config = pcall(require, "plugins." .. module)
    if not ok then
        vim.notify(module .. " config not loaded")
        return {}
    end
    return module_config
end


packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

--- @PluginList https://github.com/yutkat/my-neovim-pluginlist
--- @PluginList https://github.com/rockerBOO/awesome-neovim.git
return packer.startup(function(use)
    --------------------------------------------------------------
    -- base
    --------------------------------------------------------------
    -- TODO: change packer for folke/lazy.nvim
    use "wbthomason/packer.nvim"   -- plugin manager
    use "nvim-lua/plenary.nvim"    -- usefull collection of lua functions for neovim
    use "lewis6991/impatient.nvim" -- improve startup time
    use "nvim-lua/popup.nvim"      -- popup api implementation of vim for neovim
    use "MunifTanjim/nui.nvim"     -- UI component library
    use "ray-x/guihua.lua"         -- GUI library
    -- plugin development setup 
    use {
        "folke/neodev.nvim",
        config = function() load_config("neodev") end,
    }
    -- tools management UI (easily install lsp,dap,linters,etc)
    use {
        "williamboman/mason.nvim",
        config = function() load_config("mason") end,
        requires = {
            "williamboman/mason-lspconfig.nvim", -- bridge mason with lspconfig
            "jayp0521/mason-null-ls.nvim",       -- bridge mason with null-ls
            "jay-babu/mason-nvim-dap.nvim",      -- bridge mason with nvim-dap
        },
    }
    -- async linter
    -- use {
    --     -- prefer nvim-lint because ale create his own lsp client and is incompatible with vim.diagnostics API
    --     "mfussenegger/nvim-lint",
    --     "dense-analysis/ale" 
    --     config = function() load_config() end,
    -- }
    --  use "miversen33/netman.nvim" -- neovim (lua powered) network resource manager 


    --------------------------------------------------------------
    -- ui
    --------------------------------------------------------------
    -- colorschemes
    use "romgrk/doom-one.vim"
    use { "folke/tokyonight.nvim" , cmd = "colorscheme" }
    use { "Mofiqul/dracula.nvim" , cmd = "colorscheme" }
    use { "EdenEast/nightfox.nvim" , cmd = "colorscheme" }
    use { "nyoom-engineering/oxocarbon.nvim" , cmd = "colorscheme" }
    -- icons
    use {
        "nvim-tree/nvim-web-devicons",
        config = function() load_config("nvim-web-devicons") end,
    }
    -- file explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = function() load_config("neo-tree") end,
    }
    -- statusline (bottom bar)
    use {
        "nvim-lualine/lualine.nvim",
        config = function() load_config("lualine") end,
    }
    -- tabline (top bar)
    use {
        "nanozuki/tabby.nvim",
        config = function() load_config("tabby") end,
    }
    -- startup screen/dashboard
    -- use {
    --    "glepnir/dashboard-nvim",
    --    config = function() load_config("dashboard") end,
    -- }
    -- use {
    --    "startup-nvim/startup.nvim",
    --    config = function() load_config("startup") end,
    -- }
    -- improve input interfaces (vim.ui.input & vim.ui.select)
    use {
        "stevearc/dressing.nvim",
        config = function() load_config("dressing") end,
    }
    -- improve notifications(vim.notify)
    use {
        "rcarriga/nvim-notify",
        config = function() load_config("nvim-notify") end,
    }
    --use 'VonHeikemen/fine-cmdline.nvim' -- improve cmdline (floating cmdline)
    -- cursorline (highligh all word in buffer equals to word under cursor)
    use {
        "yamatsum/nvim-cursorline",
        config = function() load_config("nvim-cursorline") end,
    }
    use "itchyny/vim-highlighturl" -- highlighturl urls in buffer
    -- highlight, list and search notes(todo-comments)
    use {
        "folke/todo-comments.nvim",
        config = function() load_config("todo-comments") end,
    }
    -- display due dates
    use {
        "nfrid/due.nvim",
        config = function() load_config("due") end,
    }
    -- easily add highlight to comments with @{highlight}
    use {
        "folke/paint.nvim",
        config = function() load_config("paint") end,
    }
    -- fold signs
    use {
        "yaocccc/nvim-foldsign",
        config = function() load_config("nvim-foldsign") end,
    }
    -- animated signs
    -- use {
    --     "ElPiloto/significant.nvim",
    --     config = function() load_config("significant") end,
    -- }
    -- use "VonHeikemen/fine-cmdline.nvim" -- enhaced cmdline


    --------------------------------------------------------------
    -- treesiter
    --------------------------------------------------------------
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            load_config("nvim-treesitter")
        end,
        run = ":TSUpdate",
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',  -- additional text objects via treesitter
            "nvim-treesitter/playground",
            'nvim-treesitter/nvim-treesitter-context',      -- show code context
            --"RRethy/nvim-treesitter-textsubjects",
            --"p00f/nvim-ts-rainbow"                        -- highligh 
            --"windwp/nvim-ts-autotag"                      -- use treesitter to autocose & autorename html tags
            --"JoosepAlviste/nvim-ts-context-commentstring" -- to comment jsx/tsx
            --"nfrid/treesitter-utils"
        }
    }


    --------------------------------------------------------------
    -- lsp
    --------------------------------------------------------------
    use {
        "neovim/nvim-lspconfig",
        requires = {
            {   -- view status updates/progress for LSP(view ops progress)
                "j-hui/fidget.nvim",
                config = function() load_config("fidget") end,
            },
            {
                -- alternative: "jubnzv/virtual-types.nvim" -- show types anotations as virtual text
                --  LSP signature hint as typing 
                "ray-x/lsp_signature.nvim",
                config = function () load_config("lsp_signature")end,
            },
        },
        config = function() load_config("nvim-lspconfig") end,
    }
    -- lsp enhacer 
    use {
       "glepnir/lspsaga.nvim",
       config = function() load_config("lspsaga") end,
    }
    -- bridge/hook up non-LSP tools to the LSP UX through lua
    -- use neovim as a language server to inject LSP diagnostics, code actions, and more via Lua. 
    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function() load_config("null-ls") end,
    }
    -- pretty diagnostics
    use {
        "folke/trouble.nvim",
        config = function() load_config("trouble") end,
    }
    -- lsp navigation
    use {
        "ray-x/navigator.lua",
        config = function() load_config("navigator") end,
    }
    --use {
    --    "RishabhRD/nvim-lsputils",
    --    requires = "RishabhRD/popfix",
    --}


    --------------------------------------------------------------
    -- search
    --------------------------------------------------------------
    use "liuchengxu/vista.vim" -- viewer & finder for lsp symbols & tags
    -- fzf
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            load_config("telescope")
        end,
        requires = {
            "nvim-telescope/telescope-ui-select.nvim",       -- sets vim.ui.select to telescope
            "nvim-telescope/telescope-github.nvim",          -- telescope github-cli integration
	        'LukasPietzschmann/telescope-tabs',              -- search tabs
            "LinArcX/telescope-env.nvim",                    -- search environment variables
            "nvim-telescope/telescope-media-files.nvim",     -- search media files
            -- "nvim-telescope/telescope-file-browser.nvim",    -- search filesystem
            {   -- use fzf
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            {   -- search in browser bookmarks
                "dhruvmanila/telescope-bookmarks.nvim",
                tag = "*",
                requires = "kkharji/sqlite.lua",
            },
            {   -- create telescope pickers
                "axkirillov/easypick.nvim",
                config = function() load_config("easypick") end,
            },
            {
                "sopa0/telescope-makefile",
                config = function() load_config("telescope-makefile") end,
            },
            -- {
            --     "benfowler/telescope-luasnip.nvim",
            --     module = "telescope._extensions.luasnip",    -- to lazy-load
            -- },
            -- {
	            --config = function()
		        --    require'telescope-tabs'.setup{
			    --        -- Your custom config :^)
		        --    }
	            --end
            -- }
            --"nvim-telescope/telescope-cheat.nvim",         -- an attempt to recreate cheat.sh
            -- "sdushantha/fontpreview",                     -- search fonts
            --"xiyaowong/telescope-emoji.nvim",              -- search emojis
            -- "nvim-telescope/telescope-node-modules.nvim", -- search node modules
        },
    }
    -- buffer/mark management
    use {
        "j-morano/buffer_manager.nvim",
        config = function() load_config("buffer_manager") end,
    }
    -- project and session management
    use {
        "GnikDroy/projections.nvim",
        config = function() load_config("projections") end,
    }
    -- search urls in buffer
    use {
        "axieax/urlview.nvim",
        config = function() load_config("urlview") end,
    }
    -- search unicode/emojis characters management
    use {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })
        end,
    }
    use "lambdalisue/glyph-palette.vim" -- glyphs management


    --------------------------------------------------------------
    -- completion
    --------------------------------------------------------------
    -- completion engine
    use {
        "hrsh7th/nvim-cmp",
        config = function() load_config("nvim-cmp") end,
        requires = {
            "hrsh7th/cmp-buffer",       -- buffers completion source
            "hrsh7th/cmp-path",         -- paths completion source
            "hrsh7th/cmp-cmdline",      -- cmdline completion source
            "hrsh7th/cmp-nvim-lua",     -- neovim lua api completion source
            "hrsh7th/cmp-nvim-lsp",     -- lsp completion source
            "petertriho/cmp-git",       -- git completion source
            "saadparwaiz1/cmp_luasnip", -- luasnip snippet engine completion source
            "doxnit/cmp-luasnip-choice" -- luasnip choice node completion source
        }
    }
    -- snippet engine
    use {
        "L3MON4D3/LuaSnip",
        opt = false,
        config = function() load_config("luasnip") end,
    }
    -- improvements icons for completion menu
    use "onsails/lspkind.nvim"
    -- TODO: check use "ms-jpq/coq_nvim"


    --------------------------------------------------------------
    -- operational
    --------------------------------------------------------------
    -- highligh keybindings
    use {
        "folke/which-key.nvim",
        config = function() load_config("which-key") end,
    }
    use "mbbill/undotree"        -- save tree of undo operations
    use "unblevable/quick-scope" -- highligh unique chars per word in line(to use with `f`,`F`,`t`,`T`)
    use "tpope/vim-repeat"       -- make repeatable plugins operations
    use "tpope/vim-surround"     -- surround operations on vim textobjects/symbols `"`,`()` ,`[]`,`{}`,`<>`,etc
    use "tpope/vim-speeddating"  -- allow C-a/C-x to increment/decrement dates and times
    -- to close automatically `(`,`[`,`"`,`'`
    use {
        "windwp/nvim-autopairs",
        config = function() load_config("nvim-autopairs") end,
    }
    -- easily comment code(treesiter integration)
    use {
        "numToStr/Comment.nvim",
        config = function()
            load_config("Comment")
        end,
    }
    use "sbulav/nredir.nvim"               -- redirect outputs of filters(external commands) to temp sidebuffer
    use "JarrodCtaylor/vim-shell-executor" -- execute buffer in shell and view output in split pane
    --use "andymass/vim-matchup"           --  even better % fist_oncoming navigate and highlight matching words 
    --use "Wansmer/treesj"                 -- split/joint text blocks efficiently 


    --------------------------------------------------------------
    -- dap
    --------------------------------------------------------------
    use {
        "mfussenegger/nvim-dap", -- alternative "puremourning/vimspector",
        config = function() load_config("nvim-dap") end,
        requires = {
            "theHamsta/nvim-dap-virtual-text",
             "rcarriga/nvim-dap-ui",
             "leoluz/nvim-dap-go",
             "nvim-telescope/telescope-dap.nvim",
             "rcarriga/cmp-dap",
        },
    }


    --------------------------------------------------------------
    -- tools
    --------------------------------------------------------------
    -- custom submode management (create custom submodes and menus)
    use {
        "anuvyklack/hydra.nvim",
        config = function() load_config("hydra") end,
    }
    -- wiki management
    use  "vimwiki/vimwiki"
    -- use "tools-life/taskwiki" -- task management with vimwiki using taskwarrior
    -- terminal management
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function() load_config("toggleterm") end,
    }
    -- task management(vscode like task declared using json/yaml files)
    use {
        'jedrzejboczar/toggletasks.nvim',
        config = function() load_config("toggletasks") end,
    }
    use {
        'stevearc/overseer.nvim',
        config = function() load_config("overseer") end,
    }
    -- http client
    use {
        'rest-nvim/rest.nvim',
        config = function() load_config("rest") end,
    }
    -- previewiers
    use {
        -- markdow previewiersn
        'toppair/peek.nvim',
        -- "iamcco/markdown-preview.nvim",
        run = 'deno task --quiet build:fast',
        config = function() load_config("peek") end,
    }
    --  image viewers
    use "edluffy/hologram.nvim"


    --------------------------------------------------------------
    -- integrations
    --------------------------------------------------------------
    -- git
    use "tpope/vim-fugitive" -- git integration for cmdline
    use {
        -- git integration for buffers
        "lewis6991/gitsigns.nvim",
        config = function() load_config("gitsigns") end,
    }
    -- single tabpage interface for easily view diffs
    -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- use "TimUntersberger/neogit"  -- git ui
    -- use "kdheepak/lazygit.nvim"   -- open lazygit from neovim
    -- github
    use { -- edit & review github issues
        "pwntester/octo.nvim",
        config = function() load_config("octo") end,
    }
    -- neovim plugin development with rust
    --use {
    --    "noib3/nvim-oxi",
    --    config = function() load_config("nvim-oxi") end,
    --}
    --use {
    --    "willothy/nvim-utils",
    --    config = function() load_config("nvim-utils") end,
    --}
    ---- pandoc
    --use { -- latex like editing experience while writing markdown
    --    "abeleinin/papyrus",
    --    config = function() load_config("papyrus") end,
    --}


    --------------------------------------------------------------
    -- AI
    --------------------------------------------------------------
    --
    use "github/copilot.vim"
    --     config = function() load_config("copilot") end,
    -- }
    -- AI code generation plugin(OpenAI,ChatGPT and more)
    -- use { -- configure rust lsp
    --     "dense-analysis/neural",
    --     config = function() load_config("neural") end,
    -- }
    -- ChatGpt prompt
    -- use {
    --     "jackMort/ChatGPT.nvim",
    --     config = function() load_config("ChatGPT") end,
    -- }
    -- use {
    --     "madox2/vim-ai",
    --     config = function() load_config("vim-ai") end,
    -- }
    -- highlight and explain code readability issues
    -- use {
    --     "james1236/backseat.nvim",
    --     config = function() load_config("backseat") end,
    -- }
    -- use {
    --     "zbirenbaum/codeium.lua",
    --     config = function() load_config("codeium") end,
    -- }
    -- use {
    --     "dpayne/CodeGPT.nvim",
    --     config = function() load_config("CodeGPT") end,
    -- }
    -- use {
    --     "aduros/ai.vim",
    --     config = function() load_config("ai") end,
    -- }
    -- use {
    --     "jameshiew/nvim-magic",
    --     config = function() load_config("nvim-magic") end,
    -- }



    --------------------------------------------------------------
    -- languaje specific
    --------------------------------------------------------------
    -- lua
    --
    -- rust
    use { -- configure rust lsp
        "simrat39/rust-tools.nvim",
        config = function() load_config("rust-tools") end,
    }
    -- use "Saecki/crates.nvim" -- managing crates
    -- go
    --
    -- latex
    use "lervag/vimtex"


    --------------------------------------------------------------
    -- back end
    --------------------------------------------------------------



    --------------------------------------------------------------
    -- front end
    --------------------------------------------------------------
    -- colorizer
    --use {
    --    "NvChad/nvim-colorizer.lua",
    --    config = function() require("colorizer").setup({}) end,
    --}
    -- use "mhartington/formatter.nvim"  -- emmet integration
    -- use "mattn/emmet-vim"             -- emmet integration



    --------------------------------------------------------------
    -- experimental 
    --------------------------------------------------------------
    --knowledge management(wiki/notes)
    use {
        "jakewvincent/mkdnflow.nvim",
        opt = false,
    }
    use {
        "mickael-menu/zk-nvim",
        opt = false,
    }
    use {
        "renerocksai/telekasten.nvim",
        opt = false,
    }
    use "lukas-reineke/headlines.nvim" -- add horizontal headline to filetypes markdown,orgmode,etc
    -- use "itchyny/calendar.vim"         -- calendar for neovim
    use "jbyuki/instant.nvim"        -- collaborative coding
    -- motions
    use "ggandor/leap.nvim"                -- motions for every coordinate of the viewport
    -- cmds
    use "tpope/vim-dispatch"               -- asynchronous build and test dispatcher 
    use "protex/better-digraphs.nvim"      -- better digraphs
    -- tree like view for symbols
    use {
        "simrat39/symbols-outline.nvim",
        config = function() load_config("experimental.symbols-outline") end,
    }
    -- tool for test interaction
    use {
      "nvim-neotest/neotest",
      -- config = function() load_config("experimental.neotest") end,
      requires = {
        "antoinemadec/FixCursorHold.nvim"
      },
    }
    -- use "tpope/vim-dadbod",              -- db interaction
    -- use "tpope/vim-unimpaired",          -- complementary mapping
    -- use "tpope/vim-sleuth"               -- detect tabstop and shiftwidth automatically
    -- use "Exafunction/codeium.vim"
    -- use "ThePrimeagen/refactoring.nvim"  -- refactoring tool
    use "michaelb/sniprun"                  -- code runner
    -- cloud
    use { -- jupyter interaction
        'dccsillag/magma-nvim',
        run = ':UpdateRemotePlugins',
        config = function()
            vim.g.magma_automatically_open_output = false
            vim.g.magma_image_provider = "ueberzug"
        end,
    }
    -- use "luk400/vim-jukit"         -- REPL interaction

    -- git integration
    -- use "akinsho/git-conflict.nvim"      -- tool to git confligts management

    -- github integration
    -- use "Almo7aya/openingh.nvim"  -- open file or project in github for neovim wirtten in lua
    -- use {
            -- open file or project in github for neovim wirtten in lua
    --     "tjdevries/sg.nvim",
    --     build = "cargo build --workspace",
    -- }

    -- git integration
    -- sindrets/diffview.nvim
    -- junkblocker/patchreview-vim

    --  containers integration
    -- use {
    --   'dgrbrady/nvim-docker',
    --   requires = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'},
    --   rocks = '4O4/reactivex' -- ReactiveX Lua implementation
    -- }
    --  use "jamestthompson3/nvim-remote-containers"

    -- completely replaces UI for messages, cmdline and the popupmenu
    -- use "nvim-pack/nvim-spectre"   -- substitute content in various files
    -- use "ap/vim-buftabline"        -- tabs management
    -- use LintaoAmons/scratch.nvim"  -- open scratch buffers
    -- use chrishrb/gx.nvim"          -- open urls in buffer
    --use {
    --    "folke/noice.nvim",
    --    config = function() load_config("noice") end,
    --}
    -- use "SmitheshP/nvim-navbuddy" -- pop up menu to navigate buffer lsp symbols
    -- use "notomo/cmdbuf.nvim"      -- alternative cmdline
    -- use "kosayoda/nvim-lightbulb" --  VSCode bulb for neovim's built-in LSP. 

    -- remote development / collaboration
    -- use "mhinz/neovim-remote"        -- support for --remote and fiends
    -- use "chipsenkbeil/distant.nvim"  -- ALPHA STAGE: remote development from local environment 
    -- NOTE: buffers per tabs
    -- stackoverflow.com/questions/7595642/buffers-per-tab-in-vim
    -- redis.com/r/neovim/comments/101f4w0/how_can_i_get_all_buffers_of_current_tab
    -- vim.fn.tabpagebuflist() 
    -- scope.nvim / tabby.nvim


    --------------------------------------------------------------
    -- development
    --------------------------------------------------------------
     -- chisel integration(REPL solidity from foundry toolkit)
    use {
        "TheSnakeWitcher/chisel.nvim",
        config = function() load_config("chisel") end,
    }
     -- anvil integration(local blockchain from foundry toolkit)
    use {
        "TheSnakeWitcher/anvil.nvim",
        config = function() load_config("anvil") end,
    }
     -- forge integration(test framework from foundry toolkit)
    use {
        "TheSnakeWitcher/forge.nvim",
        config = function() load_config("forge") end,
    }
    -- cast integration(blockchain client inspired in rest.nvim)
    -- use {
    --     "TheSnakeWitcher/cast.nvim",
    --     config = function() load_config("cast") end,
    -- }
    -- foundry integration(test framework from foundry toolkit)
    --  foundry toolkit for web3 development
    -- use {
    --      "TheSnakeWitcher/foundry.nvim",
    --      config = function() load_config("foundry") end,
    -- }
    -- web3 tools
    -- tool list: https://github.com/ConsenSys/ethereum-developer-tools-list
    -- crypto address lens: https://marketplace.visualstudio.com/items?itemName=peetzweg.crypto-address-lens
    -- ramen ui: https://github.com/dyng/eth-ramen
    -- mythril : https://github.com/dyng/eth-ramen
    -- use {
    --      "TheSnakeWitcher/web3tools.nvim",
    --      config = function() load_config("web3") end,
    -- }
    -- use "TheSnakeWitcher/mksw.nvim"             -- boilerplate/project init/scaffold structure management
    -- use "TheSnakeWitcher/sourcify.nvim"         -- sourcify is a solidity source code and metadata verification tool
    -- use "TheSnakeWitcher/doc-patterns.nvim"     -- get patterns in comments
    -- use "TheSnakeWitcher/doc-hooks.nvim"        -- execute actions on patterns
    -- use "TheSnakeWitcher/doc-traductions.nvim"  -- traduce documentation
    -- use "TheSnakeWitcher/openzeppelin-wizard"   -- openzeppelin bindings
    -- use "TheSnakeWitcher/chat-ai"               -- openzeppelin bindings


    if packer_boostraped then
        print("=====================")
        print("installing plugins...")
        print("=====================")
        packer.sync()
    end


end)
