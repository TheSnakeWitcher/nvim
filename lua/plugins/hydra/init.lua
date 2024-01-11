local ok, hydra = pcall(require,"hydra")
if not ok then
    vim.notify("hydra config not loaded")
    return
end
