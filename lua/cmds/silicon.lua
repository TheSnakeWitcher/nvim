local ok, silicon = pcall(require,"silicon")
if not ok then
    return
end

--- @help {silicon.lua-usage}
vim.api.nvim_create_user_command("Screenshot", function(opts)
    if opts.range ~= 0 then
	    silicon.visualise_cmdline({})
    else
        silicon.visualise_cmdline({to_clip = false, visible = true})
    end
end, {
	desc = "Generate image of lines in a visual selection if range provided else from buffer",
	range = "%",
})
