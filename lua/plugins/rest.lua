local ok, rest = pcall(require, "rest-nvim")
if not ok then
	vim.notify("rest config not loaded")
	return
end

rest.setup({

	result_split_horizontal = false, -- Open request results in a horizontal split
	result_split_in_place = false,   -- Keep the http file buffer above|left when split horizontal|vertical
	skip_ssl_verification = false,   -- Skip SSL verification, useful for unknown certificates
	encode_url = true,               -- Encode URL before making request

	-- Highlight request on run
	highlight = {
		enabled = true,
		timeout = 150,
	},

	result = {
		-- toggle showing URL, HTTP info, headers at top the of result window
		show_url = true,
		show_http_info = true,
		show_headers = true,

		-- executables or functions for formatting response body [optional]
		-- set them to false if you want to disable them
		formatters = {
			json = "jq",
			html = function(body)
				return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
			end,
		},
	},

	-- Jump to request line on run
	jump_to_request = false,
	env_file = ".env",
	custom_dynamic_variables = {},
	yank_dry_run = true,

})
