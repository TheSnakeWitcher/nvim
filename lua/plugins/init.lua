local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)
local load_config = util.load_config

require("lazy").setup({

    ----------------------------------------------------------------
    -- base
    ----------------------------------------------------------------
    -- luarocks support for lazy.nvim
    -- {
    --     "vhyrro/luarocks.nvim",
    --     priority = 1001,
    --     opts = {
    --         rocks = { "magick" },
    --     },
    -- },
    "ray-x/guihua.lua",      -- GUI library
    "MunifTanjim/nui.nvim",  -- UI component library
    "nvim-lua/plenary.nvim", -- utility functions library
    {
        "folke/snacks.nvim",
        priority = 1000,
        config = function() load_config("snacks") end,
    },
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
    -- plugin development setup
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {}
    },


    --------------------------------------------------------------
    -- ui
    --------------------------------------------------------------
    -- colorschemes
    {
        -- 'NTBBloodbath/doom-one.nvim'
        "romgrk/doom-one.vim",
        lazy = true,
        priority = 1000,
        init = function()
            vim.g.doom_one_terminal_colors = true
            vim.cmd("colorscheme doom-one")
            vim.cmd("hi! link NormalFloat Normal")
            vim.cmd("hi! link LazyNormal Pmenu")
        end,
    },
    -- { "folke/tokyonight.nvim", lazy = true },
    -- { "eldritch-theme/eldritch.nvim", lazy = true },
    -- { "Mofiqul/dracula.nvim", lazy = true },
    -- { "marko-cerovac/material.nvim" , lazy = true },
    -- { "catppuccin/nvim", name = "catppuccin", lazy = true },
    -- icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function() load_config("nvim-web-devicons") end,
    },
    -- enhace ui
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {},
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        }
    },
    -- file explorer
    {
        --     -- 'stevearc/oil.nvim',
        --     "A7Lavinraj/fyler.nvim",
        --     branch = "stable",
        --     config = function() load_config("fyler") end,
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        config = function() load_config("neo-tree") end,
    },
    -- statusline
    {
        -- "rebelot/heirline.nvim",
        "nvim-lualine/lualine.nvim",
        config = function() load_config("lualine") end,
    },
    -- startup screen/dashboard
    {
        -- TODO: check if could be substituted by snacks.dashboad
        "glepnir/dashboard-nvim",
        config = function() load_config("dashboard") end,
    },
    -- view status updates/progress for LSP(view ops progress)
    {
        -- alternative(errors with rust notifications): "mrded/nvim-lsp-notify" 
        -- alternative(notifications in statusline):    "linrongbin16/lsp-progress.nvim"
        "j-hui/fidget.nvim",
        event = "LspAttach",
        config = function() load_config("fidget") end,
    },
    -- sidebar
    {
        "folke/edgy.nvim",
        ft = "trouble",
        init = function() vim.opt.splitkeep = "screen" end,
        config = function() load_config("edgy") end,
    },
    -- topbar
    -- "Bekaboo/dropbar.nvim",  -- lsp symbols in winbar(just below tabline)
    -- cursorline (highligh all word in buffer equals to word under cursor)
    {
        "yamatsum/nvim-cursorline",
        opts = { cursorline = { enable = false } },
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
    -- highlighturl parents `(` , `[` or `{`
    {
        "utilyre/sentiment.nvim",
        version = "*",
        event = "VeryLazy",
        opts = {},
        init = function() vim.g.loaded_matchparen = 1 end,
    },
    -- colorizer
    {
        'brenoprata10/nvim-highlight-colors',
        -- "norcalli/nvim-colorizer.lua",
        ft = { "md", "html", "css"},
        opts = {}
    },
    -- folds
    {
        -- "anuvyklack/fold-preview.nvim", -- fold preview
        --  "Vonr/foldcus.nvim/",          -- fold multiline comments
        "yaocccc/nvim-foldsign",
        config = function() load_config("nvim-foldsign") end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function() load_config("nvim-ufo") end,
    },
    -- vscode like icons for completion menu
    {
        "onsails/lspkind.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
    },
    {
        -- funny animation in ui
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
    -- command preview
    {
        "smjonas/live-command.nvim",
        cmd = "Norm",
        config = function() load_config("live-command") end,
    },
    "itchyny/vim-highlighturl",        -- highlighturl urls in buffer


    ----------------------------------------------------------------
    -- treesiter / lsp
    ----------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() load_config("nvim-treesitter") end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",     -- show code context
            "nvim-treesitter/nvim-treesitter-textobjects", -- additional text objects via treesitter
            "windwp/nvim-ts-autotag",                      -- use treesitter to autocose & autorename html tags
            "RRethy/nvim-treesitter-endwise",              -- add `end` to non-brackets base languajes
        },
    },
    "neovim/nvim-lspconfig",
    -- bridge/hook up non-LSP tools to the LSP UX via lua to inject LSP diagnostics, code actions 
    {
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        config = function() load_config("none-ls") end,
    },
    -- diagnostics
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function() load_config("trouble") end,
    },
    -- access to SchemaStore catalog from nvim
    {
        "b0o/schemastore.nvim",
        event = "LspAttach",
    },
    -- lsp signature hint as typing
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "LspAttach",
    --     config = function() load_config("lsp_signature") end,
    -- },
    -- formatter
    {
        "stevearc/conform.nvim",
        lazy = true,
        opts = {}
    --     config = function() load_config("conform") end,
    },
    -- {
    --     "glepnir/lspsaga.nvim",
    --     event = "LspAttach",
    --     config = function() load_config("lspsaga") end,
    -- },


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
            {
                -- use fzf
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-dap.nvim",         -- search for dap
            "FabianWirth/search.nvim",                   -- tabs for telescope layout
        },
    },
    -- telescope extensions
    -- "jmbuhr/telescope-zotero.nvim",
    {
        "nvim-telescope/telescope-ui-select.nvim",
        init = function() require("telescope").load_extension("ui-select") end
    },
    { "tsakirist/telescope-lazy.nvim", keys = "<leader>fP" },   -- search plugins installed with lazy
    { "LinArcX/telescope-env.nvim", keys = "<leader>fe" },      -- search environment variables 
    { "crispgm/telescope-heading.nvim", keys = "<leader>fH" },  -- search headers
    -- pinned buffer management
    -- {
    --     "ThePrimeagen/harpoon",
    --     branch = "harpoon2",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     init = function() require("harpoon"):setup() end
    -- },
    {
        "j-morano/buffer_manager.nvim",
        keys = { { "<leader>b", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>" } },
        config = function() load_config("buffer_manager") end,
    },
    -- project and session management
    {
        "GnikDroy/projections.nvim",
        branch = "pre_release",
        keys = { "<C-p>" ,"<leader>fp" },
        config = function() load_config("projections") end,
    },
    -- tree view/code outline for lsp symbols/tags
    {
        "stevearc/aerial.nvim",
        cmd = { "Telescope aerial",  "AerialToggle",  "AerialOpen",  "AerialOpenAll" },
        config = function() load_config("aerial") end,
    },
    -- search urls in buffer
    {
        "axieax/urlview.nvim",
        cmd = "UrlView",
        config = function() load_config("urlview") end,
    },


    --------------------------------------------------------------
    -- completion
    --------------------------------------------------------------
    -- completion engine
    -- {
    --     'saghen/blink.cmp',
    --     version = '1.*',
    --     -- config = function() load_config("blink") end,
    --     opts = {
    --         -- keymap = { preset = 'default' },
    --         -- appearance = {
    --         --   nerd_font_variant = 'mono'
    --         -- },
    --         -- completion = { documentation = { auto_show = false } },
    --         -- sources = {
    --         --   default = { 'lsp', 'path', 'snippets', 'buffer' },
    --         -- },
    --         -- opts_extend = { "sources.default" }
    --     }
    -- },
    {
        -- alternatives: https://github.com/Saghen/blink.cmp
        -- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/blink-cmp.lua
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function() load_config("nvim-cmp") end,
        dependencies = {
            "hrsh7th/cmp-buffer",        -- buffers completion source
            "hrsh7th/cmp-path",          -- paths completion source
            "hrsh7th/cmp-cmdline",       -- cmdline completion source
            "hrsh7th/cmp-nvim-lua",      -- neovim lua api completion source
            "saadparwaiz1/cmp_luasnip",  -- luasnip snippet engine completion source
            -- lsp completion source
            {
                "hrsh7th/cmp-nvim-lsp",
                event = "LspAttach",
            },
            -- completion for dap
            -- {
            --     "rcarriga/cmp-dap",
            --     cmd = "DapUI",
            -- },
            "petertriho/cmp-git",                    -- git completion source
            "uga-rosa/cmp-dynamic",                  -- dynamic generation candidates sources
            "davidsierradz/cmp-conventionalcommits", -- conventional commtis
            "kdheepak/cmp-latex-symbols",            -- latex completion source
            -- github copilot source
            -- {
            --     "zbirenbaum/copilot-cmp",
            --     dependencies = "zbirenbaum/copilot.lua",
            --     config = function () require("copilot_cmp").setup() end
            -- }
            -- "tzachar/cmp-ai",                -- ai completion source
            -- "nat-418/cmp-color-names.nvim"   -- color sources
            -- "jc-doyle/cmp-pandoc-references" -- pandoc/markdown/bibliography completion sources
            -- "jalvesaq/cmp-zotcite"           -- zotero completion sources
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
    -- https://github.com/MagicDuck/grug-far.nvim  TODO: CHECK:
    "mong8se/actually.nvim",  -- ask for correct file to open when autocompletion doesn't work because multiple files share the same prefix
    "zdcthomas/yop.nvim",     -- easier custom operator management
    "mg979/vim-visual-multi", --  enhaced multiline editing
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
    -- surround operations on vim textobjects/symbols `"`,`()` ,`[]`,`{}`,`<>`
    {
        "tpope/vim-surround",
        event = "InsertEnter"
    },
    -- allow C-a/C-x to increment/decrement dates and times
    {
        -- alternative: https://github.com/monaqa/dial.nvim
        "tpope/vim-speeddating",
        keys = { "<C-a>", "<C-x>" },
    },
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
    -- easily comment code with treesiter integration
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- popup movements
    {
        "carbon-steel/detour.nvim",
        cmd = { "Detour", "DetourCurrentWindow" },
    },
    -- redirect outputs of commands and filters(external commands) to temp sidebuffer
    {
        "sbulav/nredir.nvim",
        cmd = "Nredir"
    },
    -- split/joint text blocks efficiently
    {
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() load_config('treesj') end,
        keys = { '<leader>j' },
    },
    -- code screenshots
    {
        "michaelrommel/nvim-silicon",
        cmd = "Silicon",
        config = function() load_config("silicon") end,
    },
    {
        -- refactoring tool
        "ThePrimeagen/refactoring.nvim",
        cmd = "Refactor",
    },
    {
        -- save tree of undo operations
        "mbbill/undotree",
        keys = "<leader>u",
        cmd = { "UndotreeShow", "UndotreeToggle" },
    },
    {
        -- change words naming style (camelCase, PascalCase, kebab-case, snake_case)
        "johmsalas/text-case.nvim",
        keys = { { "gs", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" }, },
        cmd = {
            "Subs",
            "TextCaseOpenTelescope",
            "TextCaseOpenTelescopeQuickChange",
            "TextCaseOpenTelescopeLSPChange",
            "TextCaseStartReplacingCommand",
        },
        -- lazy = true,
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
    },
    -- macro management
    -- {
    --     -- must clean default @recording message 
    --     "ecthelionvi/NeoComposer.nvim",
    --     dependencies = { "kkharji/sqlite.lua" },
    -- },
    -- scratch/temp buffer management
    -- "m-demare/attempt.nvim",
    -- "LintaoAmons/scratch.nvim"
    -- "CKolkey/ts-node-action", -- run arbitrary actions in treesitter nodes
    -- "Jxstxs/conceal.nvim",    -- uses Treesitter to conceal typical boiler Code Resources


    --------------------------------------------------------------
    -- testing/debugging
    --------------------------------------------------------------
    -- tests framework/runner
    {
        -- TODO: split adapters dependencies(load adapters when LSP for ft is started)
        "nvim-neotest/neotest",
        cmd = "Neotest",
        config = function() load_config("neotest") end,
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-neotest/neotest-plenary",
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-go",
            "llllvvuu/neotest-foundry",
        },
    },
    -- dap(debug adapter protocol) integration
    {
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
    -- knowledgebase/notes management
    {
        --  "vimwiki/vimwiki",
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        config = function() load_config("obsidian") end,
    },
    -- terminal management
    {
        -- https://github.com/Rolv-Apneseth/tfm.nvim
        -- https://github.com/rebelot/terminal.nvim
        -- https://github.com/pianocomposer321/consolation.nvim
        "akinsho/toggleterm.nvim",
        keys = {
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=100<cr>" },
            { "<leader>tt", "<Cmd>ToggleTerm direction=tab<CR>" }
        },
        cmd = 'Toggleterm',
        version = '*',
        config = function() load_config("toggleterm") end,
    },
    -- task/job management
    {
        'stevearc/overseer.nvim',
        version = "1.6.0",
        keys = { "<leader>Te",  "<leader>Tr",  "<leader>TR" },
        cmds = { "OverseerToggle", "OverseerOpen", "OverseerBuild", "OverseerRun", "OverseerRunCmd" },
        config = function() load_config("overseer") end,
    },
    -- markdown preview
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        config = function() load_config("render-markdown") end,
    },
    -- help preiew
    -- {
    --     "OXY2DEV/helpview.nvim",
    --     lazy = false,
    --     ft = "help",
    -- },
    -- database interaction management
    -- {
    --     -- "https://github.com/kndndrj/nvim-dbee",
    --     -- "https://github.com/abenz1267/nvim-databasehelper",
    --     -- "tpope/vim-dadbod-completion",
    --     "tpope/vim-dadbod",
    --     cmd = "DB",
    --     dependencies = { "kristijanhusak/vim-dadbod-ui" },
    -- },
    -- doc generation
    -- https://github.com/kkoomen/vim-doge
    {
        -- annotation generations in comment
        "danymat/neogen",
        cmd = "Neogen",
        opts = {
            input_after_comment = true,
            snippet_engine = "luasnip"
        },
    },
    -- http client
    -- https://github.com/romek-codes/bruno.nvim
    -- {
    --     'rest-nvim/rest.nvim',
    --     lazy = true,
    --     dependencies = { "luarocks.nvim" },
    --     config = function() load_config("rest") end,
    -- },
    -- chekc mini.doc
    -- {
    --     -- treesitter base markdown to vimdoc convertion tool
    --     "ibhagwan/ts-vimdoc.nvim",
    --     ft = "markdown",
    -- },
    -- translation
    -- {
    --     "niuiic/translate.nvim",
    --     "potamides/pantran.nvim",
    --     cmd = "Pantran",
    -- },


    --------------------------------------------------------------
    -- integrations
    --------------------------------------------------------------
    -- git
    -- "kdheepak/lazygit.nvim",       -- open lazygit from neovim
    "tpope/vim-fugitive",             -- git integration for cmdline
    {
        -- git integration for buffers
        "lewis6991/gitsigns.nvim",
        config = function() load_config("gitsigns") end,
    },
    {
        -- "isakbm/gitgraph.nvim",
        -- "SuperBo/fugit2.nvim",
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
        -- single tabpage interface for easily view diffs
        -- https://github.com/akinsho/git-conflict.nvim
        "sindrets/diffview.nvim",
        cmd = { "Diffview", "DiffviewOpen" },
        config = function() load_config("diffview") end,
    },
    -- github
    -- "dlvhdr/gh-dash.git", -- github dashboard
    -- "rawnly/gist.nvim",   -- gist management
    -- {
    --     -- https://who.ldelossa.is/posts/gh-nvim/
    --     "ldelossa/gh.nvim",
    --     dependencies = {
    --         {
    --             "ldelossa/litee.nvim",
    --             config = function() require("litee.lib").setup() end,
    --         },
    --     },
    --     config = function() require("litee.gh").setup() end,
    -- },
    -- {
    --     -- edit & review github issues
    --     "pwntester/octo.nvim",
    --     cmd = "Octo",
    --     config = function() load_config("octo") end,
    -- },
    -- task management
    -- https://github.com/georgeharker/comment-tasks.nvim
    -- literature programming / jupyter notebooks
    -- {
    --
    --     -- https://github.com/GCBallesteros/NotebookNavigator.nvim
    --     -- alternatives old: 'dccsillag/magma-nvim',  "luk400/vim-jukit",  "GCBallesteros/jupytext.nvim"
    --     -- alternatives : https://github.com/GCBallesteros/NotebookNavigator.nvim
    --     -- resources: https://github.com/ahmedkhalf/jupyter-nvim
    --     -- "benlubas/molten-nvim",
    --     "quarto-dev/quarto-nvim",
    --     dependencies = {
    --         { "jmbuhr/otter.nvim", ft = { "markdown", "quarto" }, opts = {} }, -- lsp for code embeded in other documents 
    --     },
    --     ft = "quarto",
    --     config = function() require("quarto").setup() end,
    -- },
    -- AI
    -- "olimorris/codecompanion.nvim",
    -- "dlants/magenta.nvim",
    -- "ColinKennedy/neovim-ai-plugins,
    -- "ravitemer/mcphub.nvim"
    -- model agnostic ai integration
    -- "magicalne/nvim.ai",
    -- "gsuuon/model.nvim", 
    --  "milanglacier/minuet-ai.nvim"
    -- {
    --     "yetone/avante.nvim",
    --     version = false,
    --     build = "make",
    --     event = "VeryLazy",
    --     config = function() load_config("avante") end,
    --     dependencies = {
    --         {
    --             -- support for image pasting
    --             "HakonHarnes/img-clip.nvim",
    --             event = "VeryLazy",
    --             opts = {
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = {
    --                         insert_mode = true,
    --                     },
    --                     -- required for Windows users
    --                     use_absolute_path = true,
    --                 },
    --             },
    --         },
    --     },
    -- },
    {
       -- chatgpt
       -- https://dotfyle.com/plugins/Robitx/gp.nvim
       -- https://github.com/dense-analysis/neural
       -- https://dotfyle.com/plugins/dpayne/CodeGPT.nvim
       -- https://dotfyle.com/plugins/martineausimon/nvim-bard
       -- https://github.com/copilotlsp-nvim/copilot-lsp
       -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
       "jackMort/ChatGPT.nvim",
       cmd = "ChatGpt",
       config = function() load_config("chatgpt") end,
    },
    {
        -- codeium ai toolkit integration
        "Exafunction/codeium.nvim",
        event = "InsertEnter",
        config = function() load_config("codeium") end,
    },
    -- {
    --      -- ollama
    --      -- alternatives:
    --      -- https://github.com/jmorganca/ollama
    --      -- https://github.com/ziontee113/ollama.nvim
    --      -- https://github.com/jpmcb/nvim-llama
    --      "David-Kunz/gen.nvim"
    --      config = function() load_config("gen") end,
    -- },
    --  "zbirenbaum/copilot.lua",        -- copilot
    --  "IntoTheNull/claude.nvim"        -- claude
    --  "olimorris/codecompanion.nvim",  -- zed AI
    --  "Aider-AI/aider",                -- pair program with LLMs
    --  "codota/tabnine-nvim"            -- tabnine
    --  "supermaven-inc/supermaven-nvim" -- supermaven
    -- pandoc
    -- {
    --    -- latex like editing experience while writing markdown
    --    -- https://github.ink/aspeddro/pandoc.nvim
    --    -- https://github.com/vim-pandoc/vim-pandoc
    --    "abeleinin/papyrus",
    --    "vim-pandoc/vim-pandoc"
    --    config = function() load_config("papyrus") end,
    -- },


    ----------------------------------------------------------------
    ---- languaje
    ----------------------------------------------------------------
    -- zig
    -- rust
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^5',
    --     lazy = false,
    --     config = function() load_config("rust-tools") end,
    -- },
    -- go
    -- {
    --     "ray-x/go.nvim",
    --     ft = {"go", 'gomod'},
    --     build = ':lua require("go.install").update_all_sync()'
    -- },
    -- javascript/typescript
    {
        -- alternative: ts-languaje-server
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function() require("typescript-tools").setup({}) end,
    },
    {
        'dmmulroy/ts-error-translator.nvim',
        ft = { "typescript", "typescriptreact" },
        opts = { auto_override_publish_diagnostics = true }
    },
    -- python
    -- {
    --     "joshzcold/python.nvim",
    --     dependencies = {
    --         "mfussenegger/nvim-dap",
    --         "mfussenegger/nvim-dap-python",
    --         "neovim/nvim-lspconfig",
    --         "nvim-neotest/neotest",
    --         "nvim-neotest/neotest-python",
    --     },
    --     opts = {},
    -- },
    -- markdown
    -- { "bullets-vim/bullets.vim" },
    -- 'jakewvincent/mkdnflow.nvim',
    -- {
    --     "tadmccorkle/markdown.nvim",
    --     ft = "markdown",
    --     config = function() require("markdown").setup({
    --         enable = true,
    --         -- inline_surround = { --[[ ... ]] },
    --     })
    --     end,
    -- },
    -- latex
    {
        -- integrations
        "lervag/vimtex",
        ft = { "tex", "latex" },
        init = function() vim.g.vimtex_view_general_viewer = "okular" end
    },
    -- {
    -- -- preview
    --     "frabjous/knap",
    --     ft = { "tex", "latex" },
    -- },


    ----------------------------------------------------------------
    ---- experimental
    ----------------------------------------------------------------
    -- cross-editor collaborative coding
    {
        -- "azratul/live-share.nvim" 
        "teamtype/teamtype-nvim",
        event = "VeryLazy",
    },
    -- https://github.com/chriswritescode-dev/consolelog.nvim
    -- https://github.com/walkingshamrock/optiongroup.nvim
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


    ----------------------------------------------------------------
    ---- development
    ----------------------------------------------------------------
     -- hardhat framework for web3 development
    {
        "TheSnakeWitcher/hardhat.nvim",
        dev = true,
        ft = "solidity",
        config = function() load_config("hardhat") end,
    },
    -- foundry toolkit integration for web3 development
    {
        "TheSnakeWitcher/foundry.nvim",
        dev = true,
        ft = "solidity",
        config = function() load_config("foundry") end,
    },
    -- utilities
    -- {
    ---     -- inspired https://github.com/Pocco81/high-str.nvim
    ---     "multi-highlight.nvim",                   -- to highligh diferent visual selected text pieces
    ---  },

},{
    dev = {
        path = vim.g.path.plugin_dev,
        patterns = { vim.env.GH_USER },
    },
})
