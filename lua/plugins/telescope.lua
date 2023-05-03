local ok , telescope = pcall(require,"telescope")
if not ok then
    vim.notify "telescope config not loaded"
    return
end

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
-- local builtin = require("telescope.builtin")
-- local previewers = telescope.previewers


--------------------------------------------------------------
-- extensions
--------------------------------------------------------------


local ok , _ = pcall(telescope.load_extension,'fzf')
if not ok then vim.notify "telescope fzf extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'ui-select')
if not ok then vim.notify("telescope ui-select extension not loaded") end

local ok , _ = pcall(telescope.load_extension,'notify')
if not ok then vim.notify "telescope notify extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'projections')
if not ok then vim.notify "telescope projections extension not loaded" end

-- NOTE: overseer will deprecate toggletask
local ok , _ = pcall(telescope.load_extension,'toggletasks')
if not ok then vim.notify "telescope toggletasks extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'env')
if not ok then vim.notify "telescope env extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'aerial')
if not ok then vim.notify "telescope aerial extension not loaded" end

-- NOTE: posible tab_manager and improve of buffer_manager with deprecate this
local ok , _ = pcall(telescope.load_extension,'telescope-tabs')
if not ok then vim.notify "telescope tabs extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'bookmarks')
if not ok then vim.notify "telescope bookmarks extension not loaded" end

-- local ok , _ = pcall(telescope.load_extension,'file_browser')
-- if not ok then vim.notify "telescope file_browser extension not loaded" end
-- local ok , fb_actions = pcall(telescope.load_extension,'telescope._extensions.file_browser.actions')
-- if not ok then vim.notify "telescope file_browser actions extension not loaded" end

--local ok , _ = pcall(telescope.load_extension,'zoxide')
--if not ok then vim.notify("telescope zoxide extension not loaded") end

--local ok , _ = pcall(telescope.load_extension,'neoclip')
--if not ok then vim.notify("telescope neoclip extension not loaded") end

--local ok , _ = pcall(telescope.load_extension,'gh')
--if not ok then vim.notify("telescope gh extension not loaded") end

--local ok , _ = pcall(telescope.load_extension,'cheat')
--if not ok then vim.notify("telescope cheat extension not loaded") end

--local ok , _ = pcall(telescope.load_extension,'emoji')
--if not ok then vim.notify("telescope cheat extension not loaded") end


--------------------------------------------------------------
-- setup
--------------------------------------------------------------
telescope.setup({

    defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },

        -- previewer = true,
        -- file_previewer = previewers.vim_buffer_cat.new,
        -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        -- layout_strategy = "flex"

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

                -- ["<c-D>"] = trouble.open_with_trouble,
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
                -- ["<c-D>"] = trouble.open_with_trouble ,
            },
        },

    },

    -- default configuration for builtin pickers
    pickers = {
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    },

    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },
        bookmarks = {
            selected_browser = 'firefox', -- options: 'waterfox','vivaldi','brave','brave_beta','buku','chrome','chrome_beta','edge', 'qutebrowser' , 'safari',
            url_open_command = 'open',    -- Either provide a shell command to open the URL
            url_open_plugin = nil,        -- Available: 'vim_external', 'open_browser'
            full_path = true,             -- show bookmark full path , false show just bookmark name
            profile_name = nil,           -- 'firefox' , waterfox,vivaldi , 'brave' , 'brave_beta' , 'chrome' , 'chrome_beta' , 'edge'
            buku_include_tags = false,    -- Add a column which contains the tags for each bookmark for buku
            debug = false,                -- Provide debug messages
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        },

        media_files = {
           filetypes = {"png", "jpg", "jpeg", "mp4", "webm", "webp",},
           -- find_cmd = "rg" -- defaults to `fd`
        },

        aerial = {
              -- Display symbols as <root>.<parent>.<symbol>
              show_nesting = {
                ['_'] = false, -- This key will be the default
                json = true,   -- You can set the option for specific filetypes
                yaml = true,
              }
        },

        --emoji = {
        --      action = function(emoji)
        --        -- argument emoji is a table.
        --        -- {name="", value="", cagegory="", description=""}

        --        vim.fn.setreg("*", emoji.value)
        --        print([[Press p or "*p to paste this emoji]] .. emoji.value)

        --        -- insert emoji when picked
        --        -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
        --      end,
        --}

        -- file_browser = {
        --     -- path
        --     -- cwd
        --     cwd_to_path = false,
        --     grouped = false,
        --     files = true,
        --     add_dirs = true,
        --     depth = 1,
        --     auto_depth = false,
        --     select_buffer = false,
        --     hidden = false,
        --     -- respect_gitignore
        --     -- browse_files
        --     -- browse_folders
        --     hide_parent_dir = false,
        --     collapse_dirs = false,
        --     prompt_path = false,
        --     quiet = false,
        --     dir_icon = "",
        --     dir_icon_hl = "Default",
        --     display_stat = { date = true, size = true, mode = true },
        --     hijack_netrw = false,
        --     use_fd = true,
        --     git_status = true,
        --     mappings = {
        --         ["i"] = {
        --             ["<A-c>"] = fb_actions.create,
        --             ["<S-CR>"] = fb_actions.create_from_prompt,
        --             ["<A-r>"] = fb_actions.rename,
        --             ["<A-m>"] = fb_actions.move,
        --             ["<A-y>"] = fb_actions.copy,
        --             ["<A-d>"] = fb_actions.remove,
        --             ["<C-o>"] = fb_actions.open,
        --             ["<C-g>"] = fb_actions.goto_parent_dir,
        --             ["<C-e>"] = fb_actions.goto_home_dir,
        --             ["<C-w>"] = fb_actions.goto_cwd,
        --             ["<C-t>"] = fb_actions.change_cwd,
        --             ["<C-f>"] = fb_actions.toggle_browser,
        --             ["<C-h>"] = fb_actions.toggle_hidden,
        --             ["<C-s>"] = fb_actions.toggle_all,
        --             ["<bs>"] = fb_actions.backspace,
        --         },
        --         ["n"] = {
        --             ["c"] = fb_actions.create,
        --             ["r"] = fb_actions.rename,
        --             ["m"] = fb_actions.move,
        --             ["y"] = fb_actions.copy,
        --             ["d"] = fb_actions.remove,
        --             ["o"] = fb_actions.open,
        --             ["g"] = fb_actions.goto_parent_dir,
        --             ["e"] = fb_actions.goto_home_dir,
        --             ["w"] = fb_actions.goto_cwd,
        --             ["t"] = fb_actions.change_cwd,
        --             ["f"] = fb_actions.toggle_browser,
        --             ["h"] = fb_actions.toggle_hidden,
        --             ["s"] = fb_actions.toggle_all,
        --         },
        --         },
        --     },
    },

})
