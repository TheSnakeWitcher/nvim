local ok, neotest = pcall(require,"neotest")
if not ok then
    vim.notify("neotest don't loaded in lualine tests components")
    return {
        stats = function() return "" end,
        stats_buf = function() return "" end,
    }
end
local neotest_state = neotest.state


local M = {}


--- @param adapter_id string
--- @param path string
--- @return boolean
local function check_adapter(adapter_id, path)
    local ADAPTER_PATH_INDEX = 2
    local ADAPTER_SEPARATOR = ':'
    local adapter_path = vim.split(adapter_id, ADAPTER_SEPARATOR)[ADAPTER_PATH_INDEX]

    if vim.stricmp(adapter_path, path) == 0 then
        return true
    else
        return false
    end
end

--- @param adapter_id string 
--- @param opts table
--- @return string
local function get_tests_stats(adapter_id, opts)
    local highlights = {
        test_total = "%#NeotestNamespace#",
        test_skipped = "%#NeotestSkipped#",
        test_failed = "%#NeotestFailed#",
        test_passed = "%#NeotestPassed#",
    }

    local state = neotest_state.status_counts(adapter_id, opts)
    if not state then
        return string.format("%s %s  %s  %s  %s %s  %s %s ",
            highlights.test_total, 0,
            highlights.test_skipped, 0,
            highlights.test_failed, 0,
            highlights.test_passed, 0
        )
    else
        return string.format("%s %s  %s  %s  %s %s  %s %s ",
            highlights.test_total, state.total,
            highlights.test_skipped, state.skipped,
            highlights.test_failed, state.failed,
            highlights.test_passed, state.passed
        )
    end

end

--- @param adapters string[]
--- @param project_path string
--- @return string|nil adapter
local function get_project_adapter(adapters, project_path)
    for _, adapter_id in ipairs(adapters) do
        if check_adapter(adapter_id, project_path) then
            return adapter_id
        end
    end
    return nil
end

--- @param adapters string[]
--- @return string
local function get_current_project_adapter(adapters)
    local project_path = vim.uv.cwd()
    return get_project_adapter(adapters, project_path)
end


--- @return boolean
local function condition()
    local adapters = neotest_state.adapter_ids()
    local adaptersNumber = #adapters
    if  adaptersNumber < 1 then return false end

    local project_path = vim.uv.cwd()
    if not project_path then return false end

    if adaptersNumber < 2 then
        return check_adapter(adapters[1], project_path)
    else
        local project_adapter = get_project_adapter(adapters, project_path)
        if not project_adapter then
            return false
        else
            return true
        end
    end
end

local function condition_buf()
    local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")
    local disable_filetypes = { "neo-tree", "quickfix","neotest-summary", "trouble" }
    if vim.tbl_contains(disable_filetypes, filetype) then return false end
    return condition()
end

--- @return string test_stats
local function test_stats()
    local adapters = neotest_state.adapter_ids()
    local adapter_id = #adapters == 1 and adapters[1] or get_current_project_adapter(adapters)

    local stats = get_tests_stats(adapter_id, {})
    return stats
end

--- @return string test_stats 
local function test_stats_buf()
    local adapters = neotest_state.adapter_ids()
    local adapter_id = #adapters == 1 and adapters[1] or get_current_project_adapter(adapters)
    local bufnr = vim.api.nvim_get_current_buf()

    local stats = get_tests_stats(adapter_id, { buffer = bufnr })
    return stats
end

M.stats = { test_stats, cond = condition }
M.stats_buf = { test_stats_buf, cond = condition_buf }


return M
