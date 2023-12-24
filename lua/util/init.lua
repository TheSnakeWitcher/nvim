util = {}


function util.load_config(module)
    local ok, module_config = pcall(require, "plugins." .. module)
    if not ok then
        vim.notify(module .. " config not loaded")
        return {}
    end
    return module_config
end

util.ui = require("util.ui")
util.icons = require("util.icons")


return util
