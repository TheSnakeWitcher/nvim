local ok, anvil = pcall(require,"anvil")
if not ok then
    vim.notify "anvil config not loaded"
    return
end


anvil.setup({
    config_file_name = "data/anvil_conf.json",   -- file where to output anvil config when spawned 
})
