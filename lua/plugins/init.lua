local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

local load_config = util.load_config


--- @PluginList https://neovimcraft.com/
--- @PluginList https://dotfyle.com/
--- @PluginList https://github.com/yutkat/my-neovim-pluginlist
--- @PluginList https://github.com/rockerBOO/awesome-neovim.git
require("lazy").setup({
    ----------------------------------------------------------------
    -- base/libraries
    ----------------------------------------------------------------
    -- luarocks support for lazy.nvim
    {
        "vhyrro/luarocks.nvim",
        priority = 1001,
        opts = {
            rocks = { "magick" },
        },
    },
    "nvim-lua/plenary.nvim", -- usefull collection of lua functions for neovim
    "nvim-lua/popup.nvim",   -- popup api implementation of vim for neovim
    "ray-x/guihua.lua",      -- GUI library
    "MunifTanjim/nui.nvim",  -- UI component library
    "folke/neodev.nvim",     -- plugin development setup
    -- tools management UI to easily install lsp,dap,linters,formatters,etc
    {
        "williamboman/mason.nvim",
        priority = 100,
        config = function() load_config("mason") end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
    },
    -- network resource manager
    {
        "miversen33/netman.nvim",
        lazy = true,
        config = function() require("netman").setup() end,
    },


    --------------------------------------------------------------
    -- ui
    --------------------------------------------------------------
    -- colorschemes
    {
        "romgrk/doom-one.vim",
        priority = 1000,
        lazy = false,
        init = function() vim.cmd("colorscheme doom-one") end,
    },
    { "folke/tokyonight.nvim", lazy = true },
    { "Mofiqul/dracula.nvim",  lazy = true },
    -- { "NTBBloodbath/doom-one.nvim", lazy = true },
    -- { "doom-neovim/doom-nvim", lazy = true },
    -- { "scottmckendry/cyberdream.nvim", lazy = true, },
    -- { "catppuccin/nvim", name = "catppuccin", lazy = true },
    -- { "marko-cerovac/material.nvim" , lazy = true },
    -- icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function() load_config("nvim-web-devicons") end,
    },
    -- file explorer
    {
        -- https://github.com/Rolv-Apneseth/tfm.nvim
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        config = function() load_config("neo-tree") end,
    },
    -- statusline (bottom bar)
    -- {
    --     "rebelot/heirline.nvim",
    --     config = function() load_config("heirline") end,
    -- },
    {
        "nvim-lualine/lualine.nvim",
        config = function() load_config("lualine") end,
    },
    -- tabline (top bar)
    -- {
    --     "willothy/nvim-cokeline",
    --     config = function() load_config("nvim-cokeline") end,
    -- },
    {
        "nanozuki/tabby.nvim",
        config = function() load_config("tabby") end,
    },
    -- lsp symbols in winbar(just below tabline)
    -- {
    --     "Bekaboo/dropbar.nvim",
    --     config = function() load_config("dropbar") end,
    -- },
    -- {
    --     "glepnir/lspsaga.nvim",
    --     event = "LspAttach",
    --     config = function() load_config("lspsaga") end,
    -- },
    -- startup screen/dashboard
    {
        "glepnir/dashboard-nvim",
        config = function() load_config("dashboard") end,
    },
    -- improve input interfaces (vim.ui)
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
    -- view status updates/progress for LSP(view ops progress)
    {
        -- alternative(errors with rust notifications): "mrded/nvim-lsp-notify" 
        -- alternative(notifications in statusline):    "linrongbin16/lsp-progress.nvim"
        "j-hui/fidget.nvim",
        event = "LspAttach",
        config = function() load_config("fidget") end,
    },
    -- cursorline (highligh all word in buffer equals to word under cursor)
    {
        -- alternatives: https://github.com/tzachar/local-highlight
        "yamatsum/nvim-cursorline",
        config = function() load_config("nvim-cursorline") end,
    },
    -- highlight, list and search notes (todo-comments)
    {
        "folke/todo-comments.nvim",
        config = function() load_config("todo-comments") end,
    },
    -- easily add highlight to comments with @{highlight}
    {
        "folke/paint.nvim",
        config = function() load_config("paint") end,
    },
    "itchyny/vim-highlighturl", -- highlighturl urls in buffer
    -- "utilyre/sentiment.nvim" -- highlighturl parents `(` , `[` or `{`
    -- highlighturl indent
    {
        -- alternative https://github.com/echasnovski/mini.indentscope
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = { exclude = { filetypes = { "dashboard", "trouble", "neo-tree" } } },
    },
    -- colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function() load_config("colorizer") end,
    },
    -- folds
    {
        "yaocccc/nvim-foldsign",
        config = function() load_config("nvim-foldsign") end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function() load_config("nvim-ufo") end,
    },
    -- "malbertzard/inline-fold.nvim", -- inline fold, note: check if highligh.scm can be i
    -- "anuvyklack/fold-preview.nvim", -- fold preview
    -- {
    --      "Vonr/foldcus.nvim/",
    -- }
    -- signcolumn
    -- {
    --     "luukvbaal/statuscol.nvim",
    --     config = function() require("statuscol").setup() end,
    -- },
    -- windows
    -- {
    --     "sindrets/winshift.nvim", -- rearrange window easily
    -- },
    -- vscode like icons for completion menu
    {
        "onsails/lspkind.nvim",
        event = "InsertEnter"
    },
    -- animated signs
    -- {
    --     "ElPiloto/significant.nvim",
    --     config = function() load_config("significant") end,
    -- }
    -- wildmenu
    -- "gelguy/wilder.nvim",
    -- "VonHeikemen/fine-cmdline.nvim" -- enhaced cmdline
    -- highligh headers and codeblocks
    -- {
    --     "lukas-reineke/headlines.nvim",
    --     opts = {},
    -- },
    {
        -- funny animation in ui
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
    -- { "AckslD/messages.nvim", opts = {} }, -- buf for better messages management
    -- generic sidebar
    -- {
    --     "folke/edgy.nvim",
    --     event = "VeryLazy",
    --     init = function() vim.opt.splitkeep = "screen" end,
    --     config = function() load_config("edgy") end,
    -- },
    -- { "sidebar-nvim/sidebar.nvim" },
    -- command preview
    {
        "smjonas/live-command.nvim",
        config = function() load_config("live-command") end,
        cmd = "Norm",
    },
    -- help
    -- { "Tyler-Barham/floating-help.nvim" }, -- help in anchorable/resizable floating window
    {
        -- lsp help in split pane 
        "roobert/hoversplit.nvim",
        keys = "<leader>H",
        opts = {
            key_bindings = {
                split = "<leader>HS",
                vsplit = "<leader>HV",
                split_remain_focused = "<leader>H",
                vsplit_remain_focused = "<leader>H",
            },
        },
    },
    -- preview for lsp code actions picker 
    -- {
    --     "aznhe21/actions-preview.nvim",
    --     keys = "<leader>la",
    --     config = function() load_config("actions-preview") end,
    -- },
    -- diagnostics
    -- { "dgagn/diagflow.nvim" },             -- message of focused diagnostics in top-rigth corner


    ----------------------------------------------------------------
    -- treesiter
    ----------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() load_config("nvim-treesitter") end,
        dependencies = {
            "nvim-treesitter/playground",                  -- NOTE: deprecated
            "nvim-treesitter/nvim-treesitter-context",     -- show code context
            "JoosepAlviste/nvim-ts-context-commentstring", -- to embeded languaje trees jsx/tsx
            "nvim-treesitter/nvim-tree-docs",              -- documentation
            -- nvim-treesitter/nvim-treesitter-refactor    -- refactor module
            "nvim-treesitter/nvim-treesitter-textobjects", -- additional text objects via treesitter
            "windwp/nvim-ts-autotag",                      -- use treesitter to autocose & autorename html tags
            "RRethy/nvim-treesitter-endwise",              -- add `end` to non-brackets base languajes
        },
    },
    -- "CKolkey/ts-node-action", -- run arbitrary actions in treesitter nodes
    -- "Jxstxs/conceal.nvim",    -- uses Treesitter to conceal typical boiler Code Resources


    ----------------------------------------------------------------
    -- lsp
    ----------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "b0o/schemastore.nvim",
                event = "LspAttach",
            },
            -- lsp signature hint as typing
            {
                "ray-x/lsp_signature.nvim",
                event = "LspAttach",
                config = function() load_config("lsp_signature") end,
            },
        },
        config = function() load_config("nvim-lspconfig") end,
    },
    -- bridge/hook up non-LSP tools to the LSP UX to inject LSP diagnostics, code actions via lua
    {
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        config = function() load_config("none-ls") end,
    },
    -- diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "Trouble",  "TroubleToggle" },
        config = function() load_config("trouble") end,
    },
    -- formatter
    {
        "stevearc/conform.nvim",
        lazy = true,
        opts = {}
    },
    -- lsp navigation
    -- {
    --     "ray-x/navigator.lua",
    --     config = function() load_config("navigator") end,
    -- },
    --{
    --    "RishabhRD/nvim-lsputils",
    --    requires = "RishabhRD/popfix",
    --}
    -- lsp for code embeded in other documents 
    {
        "jmbuhr/otter.nvim",
        ft = "markdown",
        opts = {},
    },


    --------------------------------------------------------------
    -- navigation
    --------------------------------------------------------------
    -- fzf
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = { "Telescope", "TodoTelescope" },
        keys = "<leader>f",
        config = function() load_config("telescope") end,
        dependencies = {
            "tsakirist/telescope-lazy.nvim",              -- search plugins installed with lazy
            "LinArcX/telescope-env.nvim",                 -- search environment variables
            "LukasPietzschmann/telescope-tabs",           -- search tabs
            "crispgm/telescope-heading.nvim",             -- search headers
            "jvgrootveld/telescope-zoxide",               -- search zoxide paths
            {
                -- create telescope pickers from shell commands
                "axkirillov/easypick.nvim",
                config = function() load_config("easypick") end,
            },
            {
                -- use fzf
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-dap.nvim",         -- search for dap
            "FabianWirth/search.nvim",                   -- tabs for telescope layout
            -- "nvim-telescope/telescope-media-files.nvim", -- search media files
            -- "nat-418/telescope-color-names.nvim",         -- search colors
            -- "ryanmsnyder/toggleterm-manager.nvim",        -- search toggleterm terminals
            -- "nvim-telescope/telescope-cheat.nvim",  -- an attempt to recreate cheat.sh
            -- "sdushantha/fontpreview",               -- search fonts
            -- "chip/telescope-software-licenses.nvim", -- search licenses
            -- "piersolenski/telescope-import.nvim"     -- seach imports statements
        },
    },
    -- buffer and mark management
    {
        -- for tab scoped buffers "tiagovla/scope.nvim" or  "backdround/tabscope.nvim"
        -- alternative: "nvimdev/flybuf.nvim"
        "j-morano/buffer_manager.nvim",
        keys = { { "<leader>b", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>" } },
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
        -- old alternatives: https://github.com/preservim/tagbar
        "stevearc/aerial.nvim",
        cmd = { "AerialToggle",  "AerialOpen",  "AerialOpenAll" },
        config = function() load_config("aerial") end,
    },
    -- search unicode/emojis characters management
    {
        "ziontee113/icon-picker.nvim",
        cmd = { "IconPickerNormal",  "IconPickerYank",  "IconPickerInsert"},
        keys = "<A-i>",
        config = function() load_config("icon-picker") end,
    },
    -- search urls in buffer
    {
        -- "chrishrb/gx.nvim"
        "axieax/urlview.nvim",
        cmd = "UrlView",
        config = function() load_config("urlview") end,
    },
    -- search nerd fonts glyphs
    {
        -- alternative: "nvimdev/nerdicons.nvim"
        '2kabhishek/nerdy.nvim',
        cmd = 'Nerdy',
    },
    -- "s1n7ax/nvim-window-picker", -- select between open windows


    --------------------------------------------------------------
    -- completion
    --------------------------------------------------------------
    -- completion engine
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function() load_config("nvim-cmp") end,
        dependencies = {
            "hrsh7th/cmp-buffer",        -- buffers completion source
            "hrsh7th/cmp-path",          -- paths completion source
            "hrsh7th/cmp-cmdline",       -- cmdline completion source
            "hrsh7th/cmp-nvim-lua",      -- neovim lua api completion source
            -- lsp completion source
            {
                "hrsh7th/cmp-nvim-lsp",
                event = "LspAttach",
            },
            "saadparwaiz1/cmp_luasnip",  -- luasnip snippet engine completion source

            -- completion for dap
            {
                "rcarriga/cmp-dap",
                cmd = "DapUI",
            },
            "uga-rosa/cmp-dynamic",                  -- dynamic generation candidates sources
            "petertriho/cmp-git",                    -- git completion source
            "davidsierradz/cmp-conventionalcommits", -- conventional commtis
            "kdheepak/cmp-latex-symbols",            -- latex completion source
            "hrsh7th/cmp-calc",                      -- math calculation source
            -- github copilot source
            -- {
            --     "zbirenbaum/copilot-cmp",
            --     dependencies = "zbirenbaum/copilot.lua",
            --     config = function () require("copilot_cmp").setup() end
            -- }
            -- "tzachar/cmp-ai",                -- ai completion source
            -- "hrsh7th/cmp-emoji",             -- emoji completion source
            -- "nat-418/cmp-color-names.nvim"   -- color sources
            -- "jc-doyle/cmp-pandoc-references" -- pandoc/markdown/bibliography completion sources
        }
    },
    -- snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        event = "InsertEnter",
        build = "make install_jsregexp",
        config = function() load_config("luasnip") end,
    },


    --------------------------------------------------------------
    -- operational
    --------------------------------------------------------------
    "mong8se/actually.nvim",  -- ask for correct file to open when autocompletion doesn't work because multiple files share the same prefix
    "zdcthomas/yop.nvim",     -- easier custom operator management
    "mg979/vim-visual-multi", --  enhaced multiline editing
    "LunarVim/bigfile.nvim",  -- automatic option management when editing big files 
    -- keybindings help/documentation
    {
        "folke/which-key.nvim",
        config = function() load_config("which-key") end,
    },
    -- make repeatable plugins operations
    {
        "tpope/vim-repeat",
        keys = ".",
    },
    -- surround operations on vim textobjects/symbols `"`,`()` ,`[]`,`{}`,`<>`,etc , check: https://github.com/kylechui/nvim-surround
    {
        "tpope/vim-surround",
        event = "InsertEnter",
    },

    -- allow C-a/C-x to increment/decrement dates and times
    {
        "tpope/vim-speeddating",
        keys = { "<C-a>", "<C-x>" },
    },
    {
        -- save tree of undo operations
        "mbbill/undotree",
        keys = "<leader>u",
        cmd = { "UndotreeShow", "UndotreeToggle" },
    },
    -- {
    --      -- undotree visualizer
    --      "simnalamburt/vim-mundo",
    --      keys = "<leader>u",
    -- },
    {
        -- highligh unique chars per word in line(to use with `f`,`F`,`t`,`T`)
        "unblevable/quick-scope",
        event = "InsertEnter",
    },
    -- to close automatically `(`,`[`,`"`,`'`
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() load_config("nvim-autopairs") end,
    },
    -- easily comment code(treesiter integration)
    {
        "numToStr/Comment.nvim",
        config = function() load_config("Comment") end,
        keys = { "gc", "gb" },
    },
    -- popup movements
    {
        "carbon-steel/detour.nvim",
        cmd = { "Detour", "DetourCurrentWindow" },
    },
    -- macro management
    -- {
    --     -- must clean default @recording message 
    --     "ecthelionvi/NeoComposer.nvim",
    --     dependencies = { "kkharji/sqlite.lua" },
    -- },
    -- redirect outputs of commands and filters(external commands) to temp sidebuffer
    {
        "sbulav/nredir.nvim",
        cmd = "Nredir"
    },
    -- { "m-demare/attempt.nvim" }, temp buffer or scrach buffer management
    -- split/joint text blocks efficiently
    {
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() load_config('treesj') end,
        keys = { '<leader>j' },
    },
    -- move line/blocks
    -- {
    --     "willothy/moveline.nvim",
    --     build = "make",
    -- },
    --use "andymass/vim-matchup"           --  even better % fist_oncoming navigate and highlight matching words
    -- code screenshots
    {
        "0oAstro/silicon.lua",
        config = function() load_config("silicon") end,
        cmd = "Screenshot",
    },
    {
        -- refactoring tool
        "ThePrimeagen/refactoring.nvim",
        cmd = "Refactor",
    },
    -- json
    -- "gennaro-tedesco/nvim-jqx",
    -- yaml
    -- {
    --     "cuducos/yaml.nvim",
    --     ft = { "yaml" },
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-telescope/telescope.nvim",
    --     },
    -- },
    -- "mg979/vim-visual-multi",
    -- "nvimdev/template.nvim" -- template management


    --------------------------------------------------------------
    -- testing/debugging
    --------------------------------------------------------------
    -- tests framework/runner
    {
        "nvim-neotest/neotest",
        cmd = "Neotest",
        config = function() load_config("neotest") end,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-plenary",
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-go",
            "llllvvuu/neotest-foundry",
        },
    },
    -- dap(debug adapter protocol) integration
    {
        -- alternative "puremourning/vimspector",
        "mfussenegger/nvim-dap",
        cmd = "DapUI",
        config = function() load_config("nvim-dap") end,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
    },


    --------------------------------------------------------------
    -- tools
    --------------------------------------------------------------
    -- custom submodes management (create custom submodes and menus)
    -- knowledgebase/notes management
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        config = function() load_config("obsidian") end,
    },
    -- {
    --     -- wiki management and utilities for markdown files navigation and organization
    --     alternative: "vimwiki/vimwiki",
    --     'jakewvincent/mkdnflow.nvim',
    --     config = function() load_config("mkdnflow") end
    -- },
    -- submodes
    -- {
    --     "anuvyklack/hydra.nvim",
    --     lazy = true,
    --     config = function() load_config("hydra") end,
    -- },
    -- terminal management
    {
        -- alternative: https://github.com/rebelot/terminal.nvim , https://github.com/pianocomposer321/consolation.nvim
        "akinsho/toggleterm.nvim",
        -- keys = { "<leader>tf",  "<leader>tv" },
        keys = {
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=100<cr>" },
            { "<leader>tt", "<Cmd>ToggleTerm direction=tab<CR>" }
        },
        cmd = 'Toggleterm',
        version = '*',
        config = function() load_config("toggleterm") end,
    },
    -- task/jobs management
    {
        -- alternative: https://github.com/arjunmahishi/flow.nvim
        'stevearc/overseer.nvim',
        keys = { "<leader>Te",  "<leader>Tr",  "<leader>TR" },
        cmds = { "OverseerToggle", "OverseerOpen", "OverseerBuild", "OverseerRun", "OverseerRunCmd" },
        config = function() load_config("overseer") end,
    },
    -- markdown previewiers
    {
        -- alternatives:
        -- https://github.com/iamcco/markdown-preview.nvim
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
    },
    --  image previewer
    -- {
    --     "3rd/image.nvim",
    --     opts =  {},
    -- },
    -- http client
    {
        'rest-nvim/rest.nvim',
        lazy = true,
        dependencies = { "luarocks.nvim" },
        config = function() load_config("rest") end,
    },
    -- database interaction management
    {
        -- alternatives:
        -- "https://github.com/kndndrj/nvim-dbee",
        -- "https://github.com/abenz1267/nvim-databasehelper",
        -- "tpope/vim-dadbod-completion",
        "tpope/vim-dadbod",
        cmd = "DB",
        dependencies = { "kristijanhusak/vim-dadbod-ui" },
    },
    -- doc generation
    -- annotation generations in comment
    {
        "danymat/neogen",
        opts = {
            input_after_comment = true,
            snippet_engine = "luasnip"
        },
    },
    -- chekc mini.doc
    -- {
    --     -- treesitter base markdown to vimdoc convertion tool
    --     "ibhagwan/ts-vimdoc.nvim",
    --     ft = "markdown",
    -- },
    -- "milanglacier/yarepl.nvim" --

    -- conceal
    ---- use "KeitaNakamura/tex-conceal.vim",
    -- "ziontee113/color-picker.nvim", -- color picker
    -- "duane9/nvim-rg" -- run rg async from neovim

    -- translation
    -- "potamides/pantran.nvim",
    -- "niuiic/translate.nvim",



    --------------------------------------------------------------
    -- integrations
    --------------------------------------------------------------
    -- grep like tools
    -- "mhinz/vim-grepper",
    -- git
    -- use "Almo7aya/openingh.nvim"  -- open file or project in github for neovim wirtten in lua
    "tpope/vim-fugitive", -- git integration for cmdline
    {
        -- git commit browser
        "junegunn/gv.vim",
        cmd = "GV",
    },
    {
        -- generate sharable permalinks(with line ranges) for git host websites
        "linrongbin16/gitlinker.nvim",
        config = function() load_config("gitlinker") end,
        cmd = "GL",
    },
    {
        -- git integration for buffers
        "lewis6991/gitsigns.nvim",
        config = function() load_config("gitsigns") end,
    },
    {
        -- single tabpage interface for easily view diffs
        -- similar: https://github.com/akinsho/git-conflict.nvim
        "sindrets/diffview.nvim",
        cmd = { "Diffview", "DiffviewOpen" },
        config = function() load_config("diffview") end,
    },
    -- use "kdheepak/lazygit.nvim"   -- open lazygit from neovim
    -- github
    -- "dlvhdr/gh-dash.git", -- github dashboard
    -- "rawnly/gist.nvim",   -- gist management
    {
        "ldelossa/gh.nvim",
        dependencies = {
            {
            "ldelossa/litee.nvim",
            config = function()
                require("litee.lib").setup()
            end,
            },
        },
        config = function()
            require("litee.gh").setup()
        end,
    },
    {
        -- edit & review github issues
        "pwntester/octo.nvim",
        cmd = "Octo",
        config = function() load_config("octo") end,
    },
    -- pandoc
    -- {
    --    -- latex like editing experience while writing markdown
    --    -- https://github.ink/aspeddro/pandoc.nvim
    --    -- https://github.com/vim-pandoc/vim-pandoc
    --    "abeleinin/papyrus",
    --    "vim-pandoc/vim-pandoc"
    --    config = function() load_config("papyrus") end,
    -- },
    -- sourcegraph integration
    {
        "sourcegraph/sg.nvim",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        config = function() load_config("sg") end,
    },
    -- literature programming / jupyter notebooks
    -- {
    --     -- https://github.com/GCBallesteros/NotebookNavigator.nvim
    --     -- alternatives: 'dccsillag/magma-nvim',  "luk400/vim-jukit",  "GCBallesteros/jupytext.nvim"
    --     'benlubas/molten-nvim ',
    -- },
    -- AI
    -- "gsuuon/model.nvim", -- model agnostic ai integration
    -- "aduros/ai.vim",     -- generate and edit text using OpenAI and GPT.
    {
       -- chatgpt
       -- https://dotfyle.com/plugins/Robitx/gp.nvim
       -- https://github.com/dense-analysis/neural
       -- https://dotfyle.com/plugins/dpayne/CodeGPT.nvim
       -- https://dotfyle.com/plugins/martineausimon/nvim-bard
       "jackMort/ChatGPT.nvim",
       cmd = "ChatGpt",
       config = function() load_config("chatgpt") end,
    },
    {
        -- codeium ai toolkit integration
        "Exafunction/codeium.nvim",
        event = "InsertEnter",
        dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
        config = function() load_config("codeium") end,
    },
    -- {
    --     -- github copilot
    --     -- "zbirenbaum/copilot.lua",
    --     "github/copilot.vim", -- preferred
    --     config = function()
    --         vim.keymap.set("i", "<C-r>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
    --         -- vim.g.copilot_no_tab_map = true
    --         -- vim.b.copilot_enabled = true
    --     end,
    -- },
    -- {
    --      -- ollama
    --      "David-Kunz/gen.nvim"
    --      https://github.com/jmorganca/ollama
    --      https://github.com/ziontee113/ollama.nvim
    --      https://github.com/jpmcb/nvim-llama
    -- },


    ----------------------------------------------------------------
    ---- languaje
    ----------------------------------------------------------------
    -- lua
    --
    -- rust
    -- {
    --     -- TODO: replace with mrcjkb/rustaceanvim
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
    -- go
    ----
    -- latex
    -- "lervag/vimtex",
    -- "frabjous/knap",
    --
    --
    -- javascrtp/typescript
    -- {
    --      -- manage pnpm workspace with telescope
    --      "lukahartwig/pnpm.nvim",
    -- },
    -- {
    --    -- package info
    --    "vuki656/package-info.nvim",
    --    dependencies = "MunifTanjim/nui.nvim",
    --    config = function() load_config("package-info") end ,
    -- },


    ----------------------------------------------------------------
    ---- experimental
    ----------------------------------------------------------------
    -- ui
    -- "ldelossa/litee.nvim", -- ui widgets library

    --{
    --    -- lsp in statusline
    --    "nvim-lua/lsp-status.nvim",
    --}

    -- collaborative coding,check https://github.com/Floobits/floobits-neovim
    {
        "jbyuki/instant.nvim",
        cmd = "Instant",
    },

    ---- motions
    --{
    --    -- motions for every coordinate of the viewport
    --    -- alternative: flash.nvim
    --    "ggandor/leap.nvim",
    --    opt = true,
    --    config = function() load_config("leap") end,
    --}

    ---- lsp
    -- "smjonas/inc-rename.nvim" -- incremental LSP renaming based on Neovim's command-preview feature.

    ---- markdown
    -- "SidOfc/mkdx" -- markdown utils

    ---- cmds
    -- "protex/better-digraphs.nvim"      -- better digraphs

    ---- test interaction
    ---- "tpope/vim-unimpaired",          -- complementary mapping
    ---- "tpope/vim-sleuth"               -- detect tabstop and shiftwidth automatically

    ---- code runner
    --{
    --    "michaelb/sniprun",
    --    opt = true,
    --    run = "bash ./install.sh",
    --    config = function() load_config("sniprun") end,
    --}

    -- {
    --     -- develop integration with overseer
    --     "kndndrj/nvim-dbee",
    -- },

    ---- "Jxstxs/conceal.nvim"  -- conceal management

    ----  containers integration
    ---- {
    ----   'dgrbrady/nvim-docker',
    ----   rocks = '4O4/reactivex' -- ReactiveX Lua implementation
    ---- }
    ---- "jamestthompson3/nvim-remote-containers"

    ---- "nvim-pack/nvim-spectre"   -- substitute content in various files
    ---- "ap/vim-buftabline"        -- tabs management
    ---- "LintaoAmons/scratch.nvim"  -- open scratch buffers

    ---- ui
    ---- "notomo/cmdbuf.nvim"      -- alternative cmdline
    ---- "SmitheshP/nvim-navbuddy" -- pop up menu to navigate buffer lsp symbols

    ---- formater
    ---- "cbochs/grapple.nvim" -- tagging import files and manage their
    ---- "mhartington/formatter.nvim"  -- emmet integration

    ---- remote development / collaboration
    ---- "mhinz/neovim-remote"        -- support for --remote and fiends
    ---- "chipsenkbeil/distant.nvim"  -- ALPHA STAGE: remote development from local environment

    ---- NOTE: buffers per tabs
    ---- stackoverflow.com/questions/7595642/buffers-per-tab-in-vim
    ---- redis.com/r/neovim/comments/101f4w0/how_can_i_get_all_buffers_of_current_tab
    ---- vim.fn.tabpagebuflist()
    ---- scope.nvim / tabby.nvim

    -- https://github.com/someone-stole-my-name/yaml-companion.nvim


    ----------------------------------------------------------------
    ---- development
    ----------------------------------------------------------------

     -- hardhat framework for web3 development
    {
        "TheSnakeWitcher/hardhat.nvim",
        dev = true,
        lazy = true,
        filetype = "solidity",
        config = function() load_config("hardhat") end,
    },
    -- foundry toolkit integration for web3 development
    {
        "TheSnakeWitcher/foundry.nvim",
        dev = true,
        lazy = true,
        filetype = "solidity",
        config = function() load_config("foundry") end,
    },

    -- git integration
    -- graphite.nvim https://marketplace.visualstudio.com/items?itemName=Graphite.gti-vscode

    ---- integration with common web3 tools for dApp development
    ---- {
    ----      "TheSnakeWitcher/web3tools.nvim",
    ----      config = function() load_config("web3tools") end,
    ----      dependencies  = {
    ----            -- tool list: https://github.com/ConsenSys/ethereum-developer-tools-list
    ----            -- slither ( analysis diagnostic integration )
    ----            -- inline bookmarks by diligence
    ----            -- solidity visual auditor :
    ----                    https://consensys.io/diligence/blog/2019/10/solidity-visual-auditor-extension-for-vs-code/
    ---                    https://marketplace.visualstudio.com/items?itemName=tintinweb.solidity-visual-auditor&ssr=false#overview
    ----            -- mythril : https://github.com/dyng/eth-ramen
    ----            -- ramen ui: https://github.com/dyng/eth-ramen
    ----            -- crytic-compile: https://github.com/crytic/crytic-compile/#crytic-compile
    ----            -- echidna: https://github.com/crytic/echidna
    ----            -- manticore: https://github.com/trailofbits/manticore/
    ----            -- brokentoken: https://github.com/zeroknots/brokentoken
    ----      }
    ---- }

    ---- utilities to aid in dAPP development process using autocmds/cmds/and others
    ---- use {
    ----      "TheSnakeWitcher/web3utils.nvim",
    ----      config = function() load_config("web3utils") end,
    ----      dependencies  = {
    ----            "TheSnakeWitcher/ethersmode.nvim"          -- https://marketplace.visualstudio.com/items?itemName=acuarica.ethers-mode
    ----            "TheSnakeWitcher/selectorclash.nvim"       -- detect automatically storage and function selector clashes in poxy-like contracts(pattern independent)
    ----            "TheSnakeWitcher/opcodes.nvim"             -- opcode used and his price
    ----            "TheSnakeWitcher/gasmeter.nvim"            -- contract gas estimates of storage and operations
    ----            "TheSnakeWitcher/crypto-address-lens.nvim" -- https://marketplace.visualstudio.com/items?itemName=peetzweg.crypto-address-lens
    ----            "TheSnakeWitcher/sourcify.nvim"            -- sourcify is a solidity source code and metadata verification tool
    ----            "TheSnakeWitcher/inheritviz.nvim"          -- view what and from where data/methods are being inherited
    ----            "TheSnakeWitcher/openzeppelin-wizard"      -- openzeppelin bindings
    ----      }
    ---- }

    ---- AI integration
    ---- use {
    ----     "TheSnakeWitcher/phind.nvim",
    ----     config = function() load_config("phind") end,
    ---- }

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

    ---- knowledgebase management(zetelkasten or unstructured and wiki or structured)
    ---- {
    ----      "TheSnakeWitcher/knowledgebase.nvim",
    ----      -- features
    ----      --     preview like obsidian or vim help files
    ----      --     tag pane plugin from obsidian
    ----      --     citations plugin
    ----      --     admonition plugin from obsidian
    ----      --     MOCs(maps of contents)
    ----      check: https://github.com/oniony/TMSU
    ----      -- inspiration
    ----      --    "epwalsh/obsidian.nvim"
    ----      --    "renerocksai/telekasten.nvim"
    ----      --    "Furkanzmc/zettelkasten.nvim"
    ----      --    "jakewvincent/mkdnflow.nvim"
    ---- },

},{
    dev = {
        path = vim.g.path.plugin_dev,
        patterns = { vim.env.GH_USER },
    },
})
