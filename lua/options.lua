local options = {

    --------------------------------
    -- buffer
    --------------------------------
    termguicolors = true,       -- enable ui colors
    title = true,
    ruler = false,              -- show line and column number of cursor position separated by a `,`
    number = true,              -- activate line numbers
    relativenumber = true,      -- make line numbers relative
    numberwidth = 2,            -- width of line number column
    cmdheight = 1,              -- heigth of cmdline
    -- pumheight = 20,             -- maximum number of items to show in popup menu
    clipboard = "unnamedplus",
    signcolumn = "yes",         -- opt: yes,no,auto
    lazyredraw = true,          -- don't redraw buffer when executing macros
    showmode = false,           -- when on show current mode
    cursorline = true,          -- enable highlight line of cursor
    cursorlineopt = "number",   -- visual element to highlight
    timeout = true,             -- activate timeout
    timeoutlen = 500,           -- time in ms to wait for a mapped sequence to complete.
    showtabline = 2,            -- show tabline always

    -- fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",              -- remove `~` from empty lines
    },


    --------------------------------
    -- highligh
    --------------------------------
    hlsearch = false,
    incsearch = true,


    --------------------------------
    -- indent,scroll and wrap
    --------------------------------
    smartindent = true,    -- make indenting smarter again
    smarttab = true,
    expandtab = true,      -- convert tabs to spaces
    preserveindent = true, -- preserve indent structure as much as posible
    copyindent = true,     -- copy previus indentation on autoindenting
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
    foldenable= false,     -- when true folds enable by default when open files
    foldmethod= "manual",  -- :help fold-methods , options: expr
    -- foldexpr = "nvim_treesitter#foldexpr()",
    --formatexpr = "nvim_treesitter#foldexpr()",


    --------------------------------
    -- search patterns
    --------------------------------
    ignorecase = true,  -- ignore case in search patterns
    smartcase = true,


    --------------------------------
    -- gui
    --------------------------------
    guifont = "Iosevka Nerd Font Mono:h10",


    --------------------------------
    -- backup and undo
    --------------------------------
    backup = false,
    -- undofile = true
    -- undodir = vim.fn.stdpath("cache") .. "/undodir"


    --------------------------------
    -- mouse
    --------------------------------
    mouse = "a",       -- activate mouse for all modes
    mousefocus = true, -- window pointed by mouse is automatically activated

}

for key,value in pairs(options) do
    vim.opt[key] = value
end
