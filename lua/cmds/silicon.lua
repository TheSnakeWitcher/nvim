local ok, silicon = pcall(require,"silicon")
if not ok then
    return
end

--- @doc {silicon.lua-usage}
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

-- vim.api.nvim_create_user_command("ScreenshotPic", function()
--     local slurp , grim = "slurp" , "grim"
--
--     if not vim.fn.executable(slurp) or not vim.fn.executable(grim) then
--         vim.notify("missed " .. slurp .. " or " .. grim )
--         return
--     end
--
--     local buf , date = vim.fn.expand("%:t:r") , os.date()
--     local path = vim.env.HOME .. "/Pictures/Screenshots"
--     local cmd = string.format("%s | %s %s/%s-%s",slurp,grim,path,buf,date)
--     vim.notify(cmd)
--     vim.fn.system(cmd)
--     -- os.execute(cmd)
--
-- end, {
-- 	desc = "Select with cursor an screen are to take a screenshot",
-- })
