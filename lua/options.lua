--- @help {options}
--- @help {option-list}
--- @help {vim.opt}

vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.ruler = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cmdheight = 1
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes:3"
vim.opt.lazyredraw = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.conceallevel = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.preserveindent = true
vim.opt.copyindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.guifont = "Iosevka Nerd Font:h13"  --  "Hack:h9.3",  "Iosevka Nerd Font:h9.8",  "Iosevka Nerd Font:h9.7",  "Source Code Pro:h9.5"
vim.opt.sessionoptions:append({ "localoptions" })
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.mouse = "a"
