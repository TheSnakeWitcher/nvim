local status_ok, leap = pcall(require,"leap")
if not status_ok then
    vim.notify "leap config not loaded"
    return
end

leap.add_default_mappings()
-- opts = {
--     max_phase_one_targets = nil,
--     highlight_unlabeled_phase_one_targets = false,
--     max_highlighted_traversal_targets = 10,
--     case_sensitive = false,
--     equivalence_classes = { ' \t\r\n', },
--     substitute_chars = {},
--     safe_labels = { 's', 'f', 'n', 'u', 't' },
--     labels = { 's', 'f', 'n', 'j', 'k' },
--     special_keys = {
--       repeat_search = '<enter>',
--       next_phase_one_target = '<enter>',
--       next_target = {'<enter>', ';'},
--       prev_target = {'<tab>', ','},
--       next_group = '<space>',
--       prev_group = '<tab>',
--       multi_accept = '<enter>',
--       multi_revert = '<backspace>',
--     }
-- })

vim.cmd("autocmd ColorScheme * lua require('leap').init_highlight(true)")
