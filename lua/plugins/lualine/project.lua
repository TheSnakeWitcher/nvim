--- @return string|nil project
return function()
    local projections_available, Session = pcall(require, 'projections.session')
    local icon = '  '

    if not projections_available then
        return icon .. vim.uv.cwd()
    end

    local info = Session.info(vim.uv.cwd())
    if info ~= nil then
        local project_name = info.project.name
        return icon .. project_name
    end
end
