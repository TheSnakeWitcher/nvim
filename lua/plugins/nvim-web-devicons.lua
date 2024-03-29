local status_ok, nvim_web_devicons = pcall(require,"nvim-web-devicons")
if not status_ok then
    vim.notify("comment config don't loaded")
    return
end

--- @help {nvim-web-devicons-setup}
nvim_web_devicons.setup({
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
        },
     };
    color_icons = true;
    default = true;
    strict = true;
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        },
        ["hardhat.config.ts"] = {
            icon = "󰥯",
            color = "#ffff00",
            name = "Hardhat"
        },
        ["hardhat.config.js"] = {
            icon = "󰥯",
            color = "#ffff00",
            name = "Hardhat"
        }
    };
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
        },
        ["sol"] = {
            icon = "",
            color = "#4F709C",
            name = "Solidity"
        },
    };
})
