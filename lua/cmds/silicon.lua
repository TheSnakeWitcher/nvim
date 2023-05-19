local ok, silicon = pcall(require,"silicon")
if not ok then
    return
end

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

-- vim.api.nvim_create_user_command(
--      'Screenshot',
--      function({opts})
--          opts.fargs
--          require("silicon").visualise_api()
--      end ,
--      {
--          desc = "Generate image of lines in a visual selection",
--          nargs = 1,
--      }
--  )

-- vim.api.nvim_create_user_command(
--      'Screenshot',
--      function() silicon.visualise_api({}) end ,
--      {desc = "Generate image of lines in a visual selection"}
--  )
--
-- vim.api.nvim_create_user_command(
--      'ScreenshotBuf',
--      silicon.visualise_api({to_clip = false, show_buf = true}),
--      {desc = "Generate image of a whole buffer, with lines in a visual selection highlighted"}
--  )

-- vim.api.nvim_create_user_command(
--      'ScreenshotBufVisible',
--      require("silicon").visualise_api({to_clip = false, visible = true}),
--      {desc = "Generate visible portion of a buffer"}
--  )

-- vim.api.nvim_create_user_command(
--      'ScreenshotBuf',
--      require("silicon").visualise_api({to_clip = true}),
--      {desc = "Generate current buffer line in normal mode"}
--  )
