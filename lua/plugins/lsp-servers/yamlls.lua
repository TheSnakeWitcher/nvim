local ok, schemastore = pcall(require, "schemastore")
if not ok then
    vim.notify("schemastore not loaded in jsonls config")
    return nil
end

---@doc {schemastore-usage}
return {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = schemastore.yaml.schemas(),
        }
    }
}
