local ok, teamtype = pcall(require,"teamtype")
if not ok then
    vim.notify "teamtype config not loaded"
    return
end

--- @help {teamtype}
teamtype.config()
