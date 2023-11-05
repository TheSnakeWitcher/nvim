local status_ok, nvim_treesitter_config = pcall(require,"nvim-treesitter.configs")
if not status_ok then
    vim.notify("nvim-treesitter config don't loaded")
    return
end


nvim_treesitter_config.setup({

--- @doc {nvim-treesitter-quickstart}
ensure_installed = {
    "lua",
    "rust",
    "solidity",
    "go",
    "julia",
    "latex",
    "bibtex",
    "markdown",
    "markdown_inline",
    "toml",
    "json",
    "yaml",
},
auto_install = false ,
sync_install = false,
ignore_install = {},


--- @doc {nvim-treesitter-highlight-mod}
highlight = {
    enable = true,
    --disable = {}, -- list of languajes that will be disabled
    additional_vim_regex_highlighting = false,
},


--- @doc {nvim-treesitter-incremental-selection-mod}
incremenmal_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
},


--- @doc {nvim-treesitter-indentation-mod}
indent = {
    enable = true ,
    -- disable = {} ,
},


--autotag = {
--    enable = true,
--    filetypes = { "html" , "xml" },
--},


autopairs = {
    enable = true ,
    -- disable = {} ,
},


context_commentstring = {
    enable = true ,
    --enable_autocmd = false
},


--textobjects = {
--
--    select = {
--        enable = true,
--        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--        keymaps = {
--            -- You can use the capture groups defined in textobjects.scm
--            ['aa'] = '@parameter.outer',
--            ['ia'] = '@parameter.inner',
--            ['af'] = '@function.outer',
--            ['if'] = '@function.inner',
--            ['ac'] = '@class.outer',
--            ['ic'] = '@class.inner',
--        },
--    },
--
--    move = {
--        enable = true,
--        set_jumps = true, -- whether to set jumps in the jumplist
--        goto_next_start = {
--            [']m'] = '@function.outer',
--            [']]'] = '@class.outer',
--        },
--        goto_next_end = {
--            [']M'] = '@function.outer',
--            [']['] = '@class.outer',
--        },
--        goto_previous_start = {
--            ['[m'] = '@function.outer',
--            ['[['] = '@class.outer',
--        },
--        goto_previous_end = {
--            ['[M'] = '@function.outer',
--            ['[]'] = '@class.outer',
--        },
--    },
--
--    swap = {
--        enable = true,
--        swap_next = {
--            ['<leader>a'] = '@parameter.inner',
--        },
--        swap_previous = {
--            ['<leader>A'] = '@parameter.inner',
--        },
--    },
--
--},


--textsubjects = {
--    enable = true,
--    prev_selection = ',', -- (Optional) keymap to select the previous selection
--    keymaps = {
--        ['.'] = 'textsubjects-smart',
--        [';'] = 'textsubjects-container-outer',
--        ['i;'] = 'textsubjects-container-inner',
--    },
--},

--rainbow = {
--    enable = false,
--    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--    max_file_lines = 2000 -- Do not enable for files with more than specified lines
--},


--refactor = {
--    highlight_definitions = { enable = true },
--    smart_rename = {
--        enable = true,
--        keymaps = {
--            smart_rename = "trr",
--        },
--    },
--},


--query_linter = {
--    enable = true,
--    use_virtual_text = true,
--    lint_events = {"BufWrite","CursorHold"},
--},


--- @doc {playground-neovim-treesitter-playground}
playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
    },
},


--- @doc {nvim-tree-docs-setup}
tree_docs = {
    enable = false,
    spec_config = {
        jsdoc = {
            slots = {
                class = { author = true },
            },
            processors = {
                author = function()
                    return "@author Alejandro Virelles <thesnakewitcher@gmail.com>"
                end
            },
        },
        soliditydoc = {},
        rustdoc = {},
    }
},


})
