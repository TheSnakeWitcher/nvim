local status_ok, config = pcall(require,"nvim-treesitter.configs")
if not status_ok then
    vim.notify("nvim-treesitter config don't loaded")
    return
end


config.setup {

-- a list of parser names, or "maintained" to install parsers with maintainers
ensure_installed = {
    "lua",
    "rust",
    "go",
    "solidity",
    "julia",
    "latex",
    "toml",
    "json",
    "yaml",
    "help",
--  "html"
--  "css"
--  "js"
--  "ts"
--  "ts"
},
-- auto_install = true,  -- automatically install missing parsers when entering buffer
sync_install = false,    -- install parsers synchronously (only applied to `ensure_installed`)
ignore_install = { "" },   -- list of parsers to ignore installing (for "all")


highlight = {
    enable = true,
    --disable = {}, -- list of languajes that will be disabled
    additional_vim_regex_highlighting = false,
},


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


incremenmal_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
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


}
