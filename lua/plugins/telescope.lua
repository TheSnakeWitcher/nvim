local ok , telescope = pcall(require,"telescope")
if not ok then
    vim.notify "telescope config not loaded"
    return
end


local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"
-- local builtin = require("telescope.builtin")
-- local previewers = telescope.previewers

-- local ok, trouble = pcall(require,"trouble.providers.telescope")
-- if not ok then vim.notify("trouble not loaded in telescope config") end


--------------------------------------------------------------
-- extensions
--------------------------------------------------------------

for _, module in ipairs {
    "fzf",
    "notify",
    "projections",
    "dap",
    "env",
    "aerial",
    "media_files",
    "heading",
    "zoxide",

    "chisel",
    "hardhat",
    -- "telescope-tabs",
    -- "macros",
    -- "software-licenses",
    -- "neoclip",
    -- "cheat",
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

        --- @help {telescope.mappings}
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

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<leader>"] = actions.toggle_selection + actions.move_selection_better,
                -- ["<C-leader>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<space>"] = actions.toggle_selection + actions.move_selection_better,
                ["<S-space>"] = actions.toggle_selection + actions.move_selection_worse,

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

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<leader>"] = actions.toggle_selection + actions.move_selection_better,
                -- ["<C-leader>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<space>"] = actions.toggle_selection + actions.move_selection_better,
                ["<S-space>"] = actions.toggle_selection + actions.move_selection_worse,

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
        lsp_references = {
            theme = "cursor",
            show_line = false,
            layout_config = { height = 0.5, width = 0.8 },
        },
        lsp_definitions = {
            theme = "cursor",
            show_line = false,
            layout_config = { height = 0.5, width = 0.8 },
        },
        git_status = {
            mappings = {
                i = {
                    ["<leader>"] = { "<cmd>G ci<cr>", type = "command" },
                },
                n = {
                    ["<leader>"] = { "<cmd>G ci<cr>", type = "command" },
                }
            },
        },
    },

    extensions = {

        --- @help {telescope-nvim-fzf-native.nvim-telescope-setup-and-configuration:}
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

        --- @help {telescope-media-files.nvim-configuration}
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

        --- @help {telescope-heading.nvim-setup}
        heading = {
            treesitter = true,
            picker_opts = {
                layout_config = { width = 0.8 , preview_width = 0.5 },
                layout_strategy = "horizontal",

            },
        },

    },

})
