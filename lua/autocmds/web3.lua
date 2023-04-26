local web3 = vim.api.nvim_create_augroup("Web3", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "create test file for contracts in src if doesn't exist",
  group = web3,
  pattern = "*.sol",
  callback = function()
    local path = vim.fn.expand("%:p:h")
    local in_contract_dir = string.match(path, "contracts")
    local in_src_dir = string.match(path, "src")

    if in_contract_dir or in_src_dir then

      local file = string.gsub(vim.fn.expand("%:t"), ".sol", ".t.sol")
      local dir = vim.fs.dirname(path) .. "/test/"
      local matches = vim.fs.find(file, { path = dir, type = "file" })

      if #matches == 0 then
        os.execute("touch " .. dir .. file)
        vim.notify("created testfile : " .. dir .. file)
      end

    end

  end
})
