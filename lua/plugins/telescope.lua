local ok , telescope = pcall(require,"telescope")
if not ok then
    vim.notify "telescope config not loaded"
    return
end

local actions = require("telescope.actions")
-- local actions_state = require("telescope.actions.state")
-- local builtin = require("telescope.builtin")
-- local previewers = telescope.previewers

-- local ok, trouble = pcall(require,"trouble.providers.telescope")
-- if not ok then vim.notify("trouble not loaded in telescope config") end


--------------------------------------------------------------
-- extensions
--------------------------------------------------------------

for _, module in ipairs {
    "notify",
    "fzf",
    "projections",
    "toggletasks", -- NOTE: overseer will deprecate toggletask
    "env",
    "aerial",
    "telescope-tabs", -- NOTE: posible tab_manager and improve of buffer_manager with deprecate this
    "dap",
    "media_files",
    "heading",
    "zoxide",

    "chisel",
    -- "file_browser",
    -- "neoclip",
    -- "cheat",
    -- "telescope._extensions.file_browser.actions"
} do
    local ok, _ = pcall(telescope.load_extension, module)
    if not ok then
        vim.notify(string.format("%s telescope extension not loaded",module))
    end
end


---@help {telescope.setup()}
telescope.setup({

    defaults = {

        prompt_prefix = "  ",
        selection_caret = " ",
        path_display = { "smart" },

        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
            vertical = {
                mirror = false,
            },
        },

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

                -- ["<c-D>"] = trouble.open_with_trouble,
            },
        },

    },

    pickers = {
        -- now the picker_opts_table will be applied every time you call builtin_picker_name
        -- builtin_picker_name = { picker_opts_table }
        -- git_branches = {
        --     attach_mappings = function(prompt_bufnr, map)
        --         actions.select_default:replace(function()
	                -- actions.close(prompt_bufnr)
	                -- local selection = actions_state.get_selected_entry()
        --             vim.print(selection.name)
        --             vim.cmd("Git checkout ".. selection.name)
        --             -- actions.git_switch_branch(prompt_bufnr)
        --         end)
        --         return true
        --     end
        -- }
    },

    extensions = {

        ---@doc {telescope-nvim-fzf-native.nvim-telescope-setup-and-configuration:}
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
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

        ---@doc {telescope-media-files.nvim-configuration}
        media_files = {
           filetypes = {"png", "jpg", "jpeg", "mp4", "webm", "webp"},
        },

        aerial = {
              show_nesting = {
                ['_'] = false,
                json = true,
                yaml = true,
              }
        },

        ---@doc {telescope-heading.nvim-setup}
        heading = {
            treesitter = true,
            picker_opts = {
                layout_config = { width = 0.8 , preview_width = 0.5 },
                layout_strategy = "horizontal",

            },
        },

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
