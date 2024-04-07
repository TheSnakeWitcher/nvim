local ok , telescope = pcall(require,"telescope")
if not ok then
    vim.notify "telescope config not loaded"
    return
end


local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"

-- TODO: C-q keymap send to quickfix and open trouble 
-- local ok, trouble = pcall(require,"trouble.providers.telescope")
-- if not ok then vim.notify("trouble not loaded in telescope config") end


--------------------------------------------------------------
-- extensions
--------------------------------------------------------------

for _, module in ipairs({
    "fzf",
    "notify",
    "projections",
    "dap",
    "env",
    "heading",
    "aerial",
    "zoxide",
    "lazy",

    "hardhat",
    "foundry",
    -- "dap",
    -- "color_names",
    -- "telescope-tabs",
    -- "media_files",
    -- "macros",
    -- "software-licenses",
    -- "neoclip",
    -- "cheat",
}) do
    local ok, _ = pcall(telescope.load_extension, module)
    if not ok then
        vim.notify(string.format("%s telescope extension not loaded",module))
    end
end


--- @help {telescope.setup()}
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

                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

                ["<c-q>"] = actions.smart_send_to_qflist,
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,

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

                ["<c-q>"] = actions.smart_send_to_qflist,
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

        --- @help {telescope-lazy.nvim-configuratio}
        lazy = {
            mappings = {
                -- default  open_in_browser = "<C-o>",
                open_in_browser = "<C-c>d",
                open_in_file_browser = "<M-b>",
                open_in_find_files = "<C-f>",
                open_in_live_grep = "<C-g>",
                open_in_terminal = "<C-t>",
                open_plugins_picker = "<C-b>", -- Works only after having called first another action
                open_lazy_root_find_files = "<C-r>f",
                open_lazy_root_live_grep = "<C-r>g",
                change_cwd_to_plugin = "<C-o>",
                -- default change_cwd_to_plugin = "<C-c>d",
            },
        }

    },

})
