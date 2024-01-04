local ok, chatgpt = pcall(require,"chatgpt")
if not ok then
    vim.notify "chatgpt config not loaded"
    return
end


--- @help {chatgpt}
chatgpt.setup()
-- api_key_cmd = "pass services/openai | jq .api | xargs echo",
