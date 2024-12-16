util = {}

--- @param path string path to module being loaded
--- @param module string module being loaded
--- @param item_name? string name of module item being loaded
function util.load(path, module, item_name)
    local ok, module_config = pcall(require, string.format("%s.%s", path, module))
    if not ok then
        vim.notify(string.format("%s %s not loaded", module, item_name or path))
        return {}
    end
    return module_config
end

function util.load_config(module)
    return util.load("plugins", module, "config")
end

util.ui = require("util.ui")
util.icons = require("util.icons")


return util
