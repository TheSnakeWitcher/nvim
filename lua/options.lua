local options = {

    --------------------------------
    -- buffer
    --------------------------------
    termguicolors = true,
    title = true,
    ruler = false,
    number = true,
    relativenumber = true,
    numberwidth = 2,
    cmdheight = 1,
    clipboard = "unnamedplus",
    signcolumn = "yes:3",
    lazyredraw = true,
    showmode = false,
    cursorline = true,
    cursorlineopt =  "both",
    timeout = true,
    timeoutlen = 500,
    showtabline = 2,
    laststatus = 3,


    --------------------------------
    -- highligh
    --------------------------------
    hlsearch = false,
    incsearch = true,
    sessionoptions = vim.opt.sessionoptions:append("localoptions"),
    conceallevel = 2,


    --------------------------------
    -- indent,scroll and wrap
    --------------------------------
    smartindent = true,
    smarttab = true,
    expandtab = true,
    preserveindent = true,
    copyindent = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    scrolloff = 8,
    sidescrolloff = 8,
    wrap = false,


    --------------------------------
    -- splits and folds
    --------------------------------
    splitbelow = true,
    splitright = true,
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,
    -- foldexpr = "nvim_treesitter#foldexpr()",
    --formatexpr = "nvim_treesitter#foldexpr()",
    -- fillchars = {
    --     foldopen = "",
    --     foldclose = "",
    --     fold = "",
    --     foldsep = "",
    --     diff = "╱",
    --     eob = "",
    -- },


    --------------------------------
    -- search patterns
    --------------------------------
    ignorecase = true,
    smartcase = true,
    grepprg = "rg --vimgrep --smart-case --hidden --follow",
    -- grepformat^=%f:%l:%c:%m


    --------------------------------
    -- gui
    --------------------------------
    guifont = "Iosevka Nerd Font:h9.8", --  "Hack:h9.3",  "Iosevka Nerd Font:h9.7",  "Iosevka Nerd Font:h9.8",  "Source Code Pro:h9.5"


    --------------------------------
    -- backup and undo
    --------------------------------
    backup = false,
    -- undofile = true
    -- undodir = vim.fn.stdpath("cache") .. "/undodir"


    --------------------------------
    -- mouse
    --------------------------------
    mouse = "a",
    mousefocus = true,


    --------------------------------
    -- spell
    --------------------------------
    -- spell = true,
    -- spelllang = en_us,

}

for key,value in pairs(options) do
    vim.opt[key] = value
end
