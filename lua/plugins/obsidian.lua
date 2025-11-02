local ok, obsidian = pcall(require, "obsidian")
if not ok then
    vim.notify "obsidian config not loaded"
    return
end

local function get_wikis()
    local wikis = {}
    local wikis_dir = vim.g.path.knowledgebase .. "/wikis"

    -- NOTE: use vim.iter
    for dir, _ in vim.fs.dir(wikis_dir) do
        local wiki_name = string.format('wiki %s', dir)
        local wiki_path = vim.fs.joinpath(wikis_dir, dir)
        table.insert(wikis, { name = wiki_name, path = wiki_path })
    end

    return wikis
end

local function get_workspaces()
    local workspaces = {
        { name = "zettels", path = vim.g.path.knowledgebase .. "/zettels" },
        { name = "fleetings",path = vim.g.path.knowledgebase .. "/fleetings" },
        { name = "references", path = vim.g.path.knowledgebase .. "/references" },
    }
    local wikis = get_wikis()

    vim.list_extend(workspaces,wikis)
    return workspaces
end

--- @help {obsidian-setup}
obsidian.setup({
    workspaces = get_workspaces(),
    checkbox = { enable = true, order =  "󰄱 ", " ", " ", "󰰱 " },
    ui = {
        enable = true,
        update_debounce = 200,
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = " ", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" }, -- "#ecbe7b"
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
        },
    },
})
