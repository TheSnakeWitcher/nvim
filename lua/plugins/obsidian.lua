local ok, obsidian = pcall(require, "obsidian")
if not ok then
    vim.notify "obsidian config not loaded"
    return
end


--- @help {obsidian-setup}
obsidian.setup({
    workspaces = {
        { name = "zettels", path = vim.g.path.knowledgebase .. "/zettels" },
        { name = "wikis",         path = vim.g.path.knowledgebase .. "/wikis" },
        { name = "fleetings",         path = vim.g.path.knowledgebase .. "/fleetings" },
        { name = "references",         path = vim.g.path.knowledgebase .. "/references" },
    },
    ui = {
        enable = true,
        update_debounce = 200,
        checkboxes = {
            [" "] = { char = "󰄱 ", hl_group = "ObsidianTodo" },
            ["x"] = { char = " ", hl_group = "ObsidianDone" },
            [">"] = { char = " ", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱 ", hl_group = "ObsidianTilde" },
        },
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
