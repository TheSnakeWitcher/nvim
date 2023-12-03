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
    signcolumn = "yes",
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
    foldenable= false,
    foldmethod= "manual",
    foldlevel = 99,
    -- foldexpr = "nvim_treesitter#foldexpr()",
    --formatexpr = "nvim_treesitter#foldexpr()",
    -- fillchars = vim.opt.fillchars:append({
    --     foldopen = "",
    --     foldclose = "",
    --     fold = "",
    --     foldsep = "",
    --     diff = "╱",
    --     eob = "",-- remove `~` from empty lines
    -- }),


    --------------------------------
    -- highligh
    --------------------------------
    sessionoptions = vim.opt.sessionoptions:append("localoptions"),


    --------------------------------
    -- search patterns
    --------------------------------
    ignorecase = true,
    smartcase = true,


    --------------------------------
    -- gui
    --------------------------------
    guifont = "Hack:h10",


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

}

for key,value in pairs(options) do
    vim.opt[key] = value
end
