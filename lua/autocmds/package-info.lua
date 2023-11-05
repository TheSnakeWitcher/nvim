local ok,package_info = pcall(require,"package-info")
if not ok then return end

local package_info_augroup = vim.api.nvim_create_augroup("PackageInfo",{clear = false})

vim.api.nvim_create_autocmd("BufEnter",{
    pattern = "*/package.json",
    group = package_info_augroup,
    desc = "show dependencies versions",
    callback = function()
        package_info.show()
    end,
})
