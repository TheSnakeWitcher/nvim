_G.util = {}

function util.ensure_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
end

function util.ensure_packer()
    local packer_path = "/site/pack/packer/start/packer.nvim"
    local install_path = vim.fn.stdpath("data") .. packer_path

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end

    return false
end

function util.load_config(module)
    local ok, module_config = pcall(require, "plugins." .. module)
    if not ok then
        vim.notify(module .. " config not loaded")
        return {}
    end
    return module_config
end

util.headers = require("util.headers")

return util
