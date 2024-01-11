local ok, Hydra = pcall(require,"hydra")
if not ok then
    vim.notify("hydra module not loaded in git hydra")
    return
end
