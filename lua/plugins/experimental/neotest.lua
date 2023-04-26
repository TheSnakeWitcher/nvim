local ok, neotest = pcall(require,"neotest")
if not ok then
    vim.notify "neotest config not loaded"
    return
end

neotest.setup()
    --adapters = {
    --    require("neotest-go")({
    --        dap = { justMyCode = false },
    --    }),
    --    require("neotest-rust"),
    --    require("neotest-plenary"),
    --    require("neotest-vim-test")({
    --        ignore_file_types = { "python", "vim", "lua" },
    --    }),
    --},
    --library = {
    --    plugins = {
    --        "neotest",
    --    },
    --    type = true,
    --}
--})
