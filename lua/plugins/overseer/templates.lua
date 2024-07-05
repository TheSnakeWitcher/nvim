local overseer = require("overseer")


local projections_available, Session = pcall(require, 'projections.session')
if not projections_available then return end


local scripts_tmpl = {
    name = "scripts",
    params = {
        script = {
            type = "string",
            desc = "script to run",
        },
    },
    builder = function(params)
        return {
            cmd = 'sh',
            args = { params.script },
        }
    end,
}

overseer.register_template({
    name = "global scripts",
    generator = function(search,cb)
        local scripts = {}
        local scripts_dir = vim.g.scripts_dir .. "/sync"

        for script in vim.fs.dir(scripts_dir) do
            table.insert(scripts, overseer.wrap_template(
                scripts_tmpl,
                { name = string.format("script %s",script) },
                { script = string.format("%s/%s",scripts_dir,script) }
            ))
        end

        cb(scripts)
    end,
    condition = {
        callback = function(search)
            local info = Session.info(vim.uv.cwd())
            if info ~= nil and info.project.name == "nvim" then
                return true
            else
                return false
            end
        end,
    }
})
