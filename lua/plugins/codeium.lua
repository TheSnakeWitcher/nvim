local ok, codeium = pcall(require,"codeium")
if not ok then
    vim.notify "codeium config not loaded"
    return
end

codeium.setup({})
    -- config_path = "" ,
    -- bin_path =  "" , -- the path to the directory where the Codeium server will be downloaded to.
    -- api = "", -- information about the API server to use:
    -- host = "", -- the hostname
    -- port = "", -- the port
    -- tools = "", -- paths to binaries used by the plugin:
    --
    -- uname = "", -- not needed on Windows, defaults given.
    -- uuidgen = "", -- not needed on Windows, default implemenation given.
    -- curl = "", --
    -- gzip = "", -- not needed on Windows, default implemenation given using powershell.exe Expand-Archive instead
    --
    -- language_server = "", -- The path to the language server downloaded from the [official source.](https://github.com/Exafunction/codeium/releases/tag/language-server-v1.1.32)
    --
    -- -- the path to a wrapper script/binary that is used to execute any
    -- -- binaries not listed under `tools`. This is primarily useful for NixOS, where
    -- -- a FHS wrapper can be used for the downloaded codeium server.
    -- wrapper = "",
-- })
