local web3 = vim.api.nvim_create_augroup("Web3", { clear = true })

local ext = ".sol"
local test_ext = string.format(".t%s",ext)

local function create_file_and_notify(opts)
	os.execute("touch " .. opts.dir .. opts.file)
	vim.notify("created testfile: " .. opts.file)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "create test file for contracts in src if doesn't exist",
	group = web3,
	pattern = "*.sol",
	callback = function()
		local root = vim.uv.cwd()
		local path = vim.fn.expand("%:p:h")

		local in_lib_dir = string.match(path, "lib")
		local in_node_moules_dir = string.match(path, "node_moules")
		if in_lib_dir or in_node_moules_dir then return end

		local in_contracts_dir = string.match(path, "contracts")
		local in_src_dir = string.match(path, "src")
		if in_src_dir then
			local file = string.gsub(vim.fn.expand("%:t"),ext,test_ext)
			local dir = vim.fs.dirname(path) .. "/test/"
			local matches = vim.fs.find(file, { path = dir, type = "file" })

			if #matches == 0 then
				local prompt_message = "whould you like to create a test file y/n ?"
                local fn_args = {dir = dir ,file = file }
				util.ui.confirm({prompt = prompt_message}, { fn = create_file_and_notify, args = fn_args })
			end
		end

        -- if in_contracts_dir then
        --     -- code --
        -- end

	end,
})
