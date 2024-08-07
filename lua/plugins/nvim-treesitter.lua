local ok, nvim_treesitter_config = pcall(require,"nvim-treesitter.configs")
if not ok then
    vim.notify("nvim-treesitter config don't loaded")
    return
end


--- @help {ts-context-commentstring-commentstring-configuration}
local ok, ts_context_commentstring = pcall(require,'ts_context_commentstring')
if ok then
    vim.g.skip_ts_context_commentstring_module = true
    ts_context_commentstring.setup()
end


--- @help {nvim-treesitter-quickstart}
nvim_treesitter_config.setup({

ensure_installed = {
    "vimdoc",
    "lua",
    "bash",
    "rust",
    "solidity",
    "go",
    "julia",
    "latex",
    "bibtex",
    "query", -- for treesitter queries
    "markdown",
    "markdown_inline",
    "toml",
    "json",
    "yaml",
},
auto_install = false ,
sync_install = false,
ignore_install = {},


--- @help {nvim-treesitter-highlight-mod}
highlight = {
    enable = true,
    disable = { "latex" },
},


--- @help {nvim-treesitter-incremental-selection-mod}
incremenmal_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
},


--- @help {nvim-treesitter-indentation-mod}
indent = { enable = true },


--- @help {nvim-ts-autotag-setup}
autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
},


autopairs = {
    enable = true ,
    -- disable = {} ,
},


--- @help {nvim-treesitter-text-objects-select-submod}
textobjects = {

   select = {
       enable = true,
       lookahead = true,
       keymaps = {
           -- You can use the capture groups defined in textobjects.scm
           ['af'] = '@function.outer',
           ['if'] = '@function.inner',
           ['ac'] = '@class.outer',
           ['ic'] = '@class.inner',
           ['aa'] = '@parameter.outer',
           ['ia'] = '@parameter.inner',
       },
   },

   move = {
       enable = true,
       set_jumps = true, -- whether to set jumps in the jumplist
       goto_next_start = {
           [']f'] = '@function.outer',
           -- [']]'] = '@class.outer',
       },
       goto_next_end = {
           [']F'] = '@function.outer',
           -- [']['] = '@class.outer',
       },
       goto_previous_start = {
           ['[f'] = '@function.outer',
           -- ['[['] = '@class.outer',
       },
       goto_previous_end = {
           ['[F'] = '@function.outer',
           -- ['[]'] = '@class.outer',
       },
   },

   -- swap = {
   --     enable = true,
   --     swap_next = {
   --         ['<leader>a'] = '@parameter.inner',
   --     },
   --     swap_previous = {
   --         ['<leader>A'] = '@parameter.inner',
   --     },
   -- },

},


--textsubjects = {
--    enable = true,
--    prev_selection = ',', -- (Optional) keymap to select the previous selection
--    keymaps = {
--        ['.'] = 'textsubjects-smart',
--        [';'] = 'textsubjects-container-outer',
--        ['i;'] = 'textsubjects-container-inner',
--    },
--},

-- rainbow = {
--    enable = true,
--    extended_mode = true,
--    max_file_lines = 2000
-- },


--refactor = {
--    highlight_definitions = { enable = true },
--    smart_rename = {
--        enable = true,
--        keymaps = {
--            smart_rename = "trr",
--        },
--    },
--},


--- @help {playground-neovim-treesitter-playground}
playground = {
    disable = {},
    enable = true,
    updatetime = 25,
    persist_queries = false,
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

--- @help {playground-query-linter}
query_linter = {
   enable = true,
   use_virtual_text = true,
   lint_events = { "BufWrite","CursorHold" },
},


--- @help {nvim-tree-docs-setup}
tree_docs = {
    enable = true,
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


--- @help {nvim-treesitter-quick-start}
endwise = {
    enable = true
}


})
