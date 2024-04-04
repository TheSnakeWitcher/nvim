local ok, neo_tree = pcall(require, "neo-tree")
if not ok then
    vim.notify "neo-tree config not loaded"
    return
end

--- @help {neo-tree-configuration}
neo_tree.setup({

    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false,
    sort_function = nil,

    -- sources = {
    --     "document_symbols",
    --     "netman.ui.neo-tree",
    -- },

    --- @help {neo-tree-source-selector}
    source_selector = {
        winbar = true,
        sources = {
            { source = "filesystem", display_name = " 󰈙 Files " },
            { source = "buffers", display_name = "  Buffers " },
            { source = "git_status", display_name = " 󰊢 Git " },
            -- { source = "document_symbols", display_name = "  Symbols" },
            -- { source = "netman.ui.neo-tree", display_name = " 󰢹 Netman" },
        },
    },

    filesystem = {
        --- @help {neo-tree-filtered-items}
        filtered_items = {},
        follow_current_file = {
            enabled = true,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
            }
        }
    },

    --- @help {neo-tree-component-configs}
    default_component_configs = {
        container = {
            enable_character_fade = true
        },

        --- @help {neo-tree-expanders}
        indent = {
            padding = 1,
            with_expanders = nil,
            expander_collapsed = "",
            expander_expanded = "",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = "",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                added     = "",
                modified  = "",
                deleted   = "",
                renamed   = "➜",
                untracked = "",
                ignored   = "◌",
                unstaged  = "✗",
                staged    = "✓",
                conflict  = "",
            }
        },
    },
    windo = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
                "add",
                config = {
                    show_path = "none"
                }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        }
    },
    nesting_rules = {},
    buffers = {
        follow_current_file = {
            enabled = true,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
            }
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            }
        }
    }

})
