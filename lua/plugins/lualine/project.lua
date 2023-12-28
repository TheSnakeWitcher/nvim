--- @return string|nil project
return function()
    local projections_available, Session = pcall(require, 'projections.session')
    if projections_available then
        local info = Session.info(vim.loop.cwd())
        if info ~= nil then
            local project_name = info.project.name
            return '  ' .. project_name
        end
    end
    return vim.fs.basename(vim.loop.cwd())
end
