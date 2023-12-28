--- @help {lualine-diff-component-options}
return {
    'diff',
    globalstatus = false,
    symbols = {
        added = require('util.icons').GitAdd .. " " or ' ',
        modified = require('util.icons').GitChange .. " " or ' ',
        removed = require('util.icons').GitDelete .. " " or ' ',
    },
}
