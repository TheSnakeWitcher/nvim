local ok, schemastore = pcall(require, "schemastore")
if not ok then
    vim.notify("schemastore not loaded in jsonls config")
    return nil
end

---@help {schemastore-usage}
return {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        }
    }
}
