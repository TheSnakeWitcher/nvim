for _, module in ipairs {
    "cmds.web3",
    "cmds.peek",
} do
  local status_ok, _ = pcall(require, module)
  if not status_ok then
        vim.notify(module .. "cmds  not loaded")
    end
end
