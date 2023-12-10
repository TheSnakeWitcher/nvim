local conf = require("telescope.config").values
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")


local inner_picker = Picker:new({
    prompt_title = "Prompt2",
    finder = finders.new_table({
        results = (function()
            return func2()
        end)()
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(
            function()
                selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local val2 = selection.value
                fun(val1, val2)
            end)
        return true
    end
})

Picker:new {
    prompt_title = "Prompt1",
    finder = finders.new_table {
        results = (function()
            return func1()
        end)()
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            local val1 = selection.value
            actions.close(prompt_bufnr)
            inner_picker:find()
        end)
        return true
    end
}:find()
