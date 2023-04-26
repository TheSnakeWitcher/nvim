local ok , telescope = pcall(require,"telescope")
if not ok then
    vim.notify "telescope config not loaded"
    return
end

local actions = require("telescope.actions")
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

-- local ok , _ = pcall(telescope.load_extension,'luasnip')
-- if not ok then vim.notify "telescope luasnip extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'make')
if not ok then vim.notify "telescope make extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'env')
if not ok then vim.notify "telescope env extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'telescope-tabs')
if not ok then vim.notify "telescope tabs extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'toggletasks')
if not ok then vim.notify "telescope toggletasks extension not loaded" end

local ok , _ = pcall(telescope.load_extension,'bookmarks')
if not ok then vim.notify "telescope bookmarks extension not loaded" end

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
            },
        },

    },

    pickers = {
    -- Default configuration for builtin pickers goes here:
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
        --media_files = {
        --    filetypes = {"png", "jpg", "jpeg", "mp4", "webm", "webp",},
        --    -- find_cmd = "rg" -- defaults to `fd`
        --},
        --
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

    },

})
