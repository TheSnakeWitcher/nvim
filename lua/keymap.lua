-------------------------------------------------------------
-- documentation
--------------------------------------------------------------
-- Modes:
--     normal_mode = "n"
--     insert_mode = "i"
--     select_mode = "s"
--     visual_mode = "v"
--     visual_block_mode = "x"
--     term_mode = "t"
--     command_mode = "c"
-- Special keys:
--     < C >      = control
--     < S >      = shifth
--     < A >      = alt
--     < ESC >    = escape
--     < CR >     = enter (stands for [C]arrier [R]eturn)
--     < leader > = user seted leader key
--     <nop> = do nothing action

local set = vim.keymap.set
local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

-- TODO:
-- ]] [[ references management
-- ][ e for errors
-- ][ w for warnings
-- ][ d for diagnostics
-- ][ n for diagnostics
-- ][ t for test

--------------------------------------------------------------
-- help
--------------------------------------------------------------
require("yop").op_map({"n", "v"}, "<leader>h", function(lines, info)
    vim.cmd(string.format("help %s",lines[1]))
end)


--------------------------------------------------------------
-- builtins
--------------------------------------------------------------
-- set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
set("i", "<C-c>", "<Esc>",{ silent = true })
-- set("v", "S", ":s/\v/g<LEFT><LEFT>",{desc = "substitute pattern in range globally"})

-- folds
-- set("c", "C-h","<cmd>history<cr>",{desc = "command history"})
--
-- cmdline
-- set("n", "zft","za",{desc = "[z]creen [f]old [t]oggle"})
--
-- set("n", "s", "<Nop>",{desc = "substitute pattern globally"})
-- set("n", "S", ":%s/\v/g<LEFT><LEFT>",{desc = "substitute pattern globally"})
-- set("v", "s", ":s/\v/<LEFT><LEFT>",{desc = "substitute pattern in range"})
-- set("n", "M", ":%s/'.@/.'//g<LEFT><LEFT>",{desc = "substitue global"})


--------------------------------------------------------------
-- conventional operations
--------------------------------------------------------------
--set({"i","n","v","x"}, "<C-c>", "\"\"y",{desc = "conventional copy"})
--set({"i","n","v","x"}, "<C-v>", "\"\"p",{desc = "conventional paste"})
--set({"i","n","v","x"}, "<C-p>", "\"\"p",{desc = "conventional paste alternative"})
--set({"i","n","v","x"}, "<C-z>", "<esc>u",{desc = "conventional undo"})
--set({"i","n","v","x"}, "<C-s>", "<cmd>:w<cr>",{desc = "conventional save"})
--set("n","<C-S>","<cmd>w!<cr>",{desc = "force converntional save"})
--set("n","<C-q>","<cmd>q<cr>",{desc = "conventional quit"})
--set("n","<C-n>","<cmd>enew<cr>",{desc = "conventional new file"})
--set("n","<C-q>","<cmd>q!<cr>",{desc = "conventional force quit"})
--set("n","|","<cmd>vsplit<cr>",{desc = "force vertical split"})
--set("n","\\","<cmd>split<cr>",{desc = "horizontal split"})


--------------------------------------------------------------
-- paste(yank) & delete
--------------------------------------------------------------
set({"v","x"}, "<leader>p", "\"_dP",{desc = "delete without copy selected content and paste"})
set({"n","v"}, "<leader>d", "\"_d",{desc = "delete to hold register"})
set({"n","v"}, "<leader>y", "\"+y",{desc = "copy to system clipboard"})
set("n", "<leader>Y", "\"+Y",{desc = "copy to system clipboard entire line"})


--------------------------------------------------------------
-- center search results 
--------------------------------------------------------------
set("n", "n", "nzz")
set("n", "N", "Nzz")


--------------------------------------------------------------
-- buffer navigations
--------------------------------------------------------------
set("n", "<S-l>", ":tabnext<CR>", opts)
set("n", "<S-h>", ":tabprev<CR>", opts)
set("n", "]b", ":bnext<CR>", opts)
set("n", "[b", ":bprevious<CR>", opts)


--------------------------------------------------------------
-- window navigation
--------------------------------------------------------------
set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-l>", "<C-w>l", opts)

--set("n", "<leader>th>", "<C-w>t<C-w>H", opts)
--set("n", "<leader>tk>", "<C-w>t<C-w>K", opts)

-- set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


--------------------------------------------------------------
-- resize windows with arrows
--------------------------------------------------------------
set("n", "<C-Up>", ":resize -5<CR>", opts)
set("n", "<C-Down>", ":resize +5<CR>", opts)
set("n", "<C-Left>", ":vertical resize -5<CR>", opts)
set("n", "<C-Right>", ":vertical resize +5<CR>", opts)


--------------------------------------------------------------
-- stay in visual mode when indenting
--------------------------------------------------------------
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)


--------------------------------------------------------------
-- move blocks of text
--------------------------------------------------------------
set({"v","x"}, "<C-j>", ":move '>+1<CR>gv-gv", opts)
set({"v","x"}, "<C-k>", ":move '<-2<CR>gv-gv", opts)
--set("n", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)
--set("n", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)

--set({"v","x"}, "J", ":m '>+1<CR>gv=gv")
--set({"v","x"}, "K", ":m '<-2<CR>gv=gv")


--------------------------------------------------------------
-- telescope
--------------------------------------------------------------
-- vim pickers
set('n', '<leader>/', "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = '[/] Fuzzily search in current buffer]' })
set("n" , "<leader>sh" , "<cmd>Telescope help_tags<cr>", {desc = "[s]earch [h]elp" })
set("n" , "<leader>sm" , "<cmd>Telescope marks<cr>", {desc = "[s]earch [m]arks" })
set("n" , "<leader>sr" , "<cmd>Telescope registers<cr>",{desc = "[s]earch [r]registers" })
set("n" , "<leader>sk" , "<cmd>Telescope keymaps<cr>",{desc = "[s]earch [k]eymaps" })
set("n" , "<leader>sc" , "<cmd>Telescope command_history<cr>",{desc = "[s]earch [c]ommand history" })

set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[s]earch [d]iagnostics"})
set("n", "<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "[s]earch [q]uickfix"})

-- file pickers
set("n", "<C-f>", "<cmd> Telescope git_files<cr>", {desc = "[s]earch [g]itfiles(tracked by git according to .gitignore)" })
set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", {desc = "[s]earch [f]iles" })
set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", {desc = "[s]earch [g]rep" })
set("n","<leader>so", "<cmd>Telescope oldfiles<cr>",{desc = "[s]earch [o]ldfiles"})
set("n","<leader>sP","<cmd>Telescope media_files<cr>",{desc = "[s]earch [P]ics"})
--set("n","<leader>sF",
--    function () builtin.find_files{ hidden = true, no_ignore = true} end,
--    telescope_opts
--} -- search all files

-- lsp pickers
-- set('n', '<leader>s', builtin.lsp_definitions, {desc = "[s]earch [t]reesitter"})

-- git pickers
set("n","<C-s>","<cmd>Telescope git_status<cr>", {desc = "[s]earch [S]tatus"})
set("n","<leader>sS","<cmd>Telescope git_status<cr>", {desc = "[s]earch [S]tatus"})
set("n", "<leader>sB", "<cmd>Telescope git_branches<cr>", {desc = "[s]earch [B]ranches"})
set("n", "<leader>sC", "<cmd>Telescope git_commits<cr>", {desc = "[s]earch [C]ommits"})

-- extensions pickers
set("n", "<leader>sn", "<cmd>TodoTelescope<CR>", { desc = "[s]earch [n]otes"})                     -- todo-comments
set("n", "<leader>sN", "<cmd>Telescope notify<CR>", { desc = "[s]earch [N]otifications"})          -- notify
set("n", "<leader>sp", "<cmd>Telescope projections<CR>" ,{ desc = "[s]earch [p]rojects"})          -- projections
set("n", "<C-p>", "<cmd>Telescope projections<CR>" ,{ desc = "[s]earch [p]rojects"})               -- projections
set("n", "<leader>se", "<cmd>Telescope env<CR>" ,{ desc = "[s]earch [e]nvironment"})               -- telescope-env
set("n", "<leader>st", "<cmd>Telescope telescope-tabs list_tabs<CR>" ,{ desc = "[s]earch [t]abs"}) -- telescope-tabs
set("n", "<leader>sH", "<cmd>Telescope heading<cr>", { desc = "[s]earch [H]eaders"})               -- telescope-heading


--------------------------------------------------------------
-- Diagnostic keymaps
--------------------------------------------------------------
--set('n', '<leader>D', vim.diagnostic.open_float, opts)
set('n', '[d', vim.diagnostic.goto_prev, opts)
set('n', ']d', vim.diagnostic.goto_next, opts)
set('n', '<space>q', vim.diagnostic.setloclist, opts)
--set('n', '[d', vim.diagnostic.goto_prev)
--set('n', ']d', vim.diagnostic.goto_next)
--set('n', '<leader>e', vim.diagnostic.open_float)


--------------------------------------------------------------
-- quickfix list
--------------------------------------------------------------
--set('n', '<leader>q', vim.diagnostic.setloclist)
set('n', ']q', "<cmd>cnext<cr>",{ desc = "go to next item in quickfix"})
set('n', '[q', "<cmd>cprevious<cr>",{ desc = "go to previous item in quickfix"})
set('n', ']Q', "<cmd>clast<cr>", { desc = "go to last item in quickfix"})
set('n', '[Q', "<cmd>cfirst<cr>", { desc = "go to first item in quickfix"})


--------------------------------------------------------------
-- luasnip
--------------------------------------------------------------
set("n", "<leader>ss", "<CMD>LuaSnipEdit<CR>" ,{ desc = "[s]earch [s]snippets", silent = true })
set({"i","s"},"<C-s>",function()
    if require('luasnip').choice_active() then
        require('luasnip.extras.select_choice')()
    end
end,{desc = "select choice" , silent = true})


--------------------------------------------------------------
-- buffer_manager
--------------------------------------------------------------
set("n", "<leader>b","<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>",{})
local keys = '123456789'
for i = 1, #keys do
  local key = keys:sub(i,i)
  set(
    'n',
    string.format('<A>%s', key),
    function () require("buffer_manager.ui").nav_file(i) end,
    {}
  )
end


--------------------------------------------------------------
-- toggleterm
--------------------------------------------------------------
set("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", { desc = "[t]erminal [f]loat" })
set("n", "<leader>tv", "<Cmd>ToggleTerm direction=vertical size=100<CR>", { desc = "[t]erminal [v]ertical" })


--------------------------------------------------------------
-- urlview
--------------------------------------------------------------
set("n", "<leader>su", "<Cmd>UrlView buffer<CR>", { desc = "[s]earch [u]rls in buffer" })
set("n", "<leader>sU", "<Cmd>UrlView lazy<CR>", { desc = "[s]earch [U]rls of plugins" })


--------------------------------------------------------------
-- tabby
--------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { desc = "create new tab",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tq", ":tabclose<CR>", {desc = "close selected tab", noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { desc = "close all tabs except selected",noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { desc = "select next tab",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { desc = "select previous tab",noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { desc = "move current tab to next position",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { desc = "move current tab to previous position" , noremap = true })

set("n", "<leader>tl", "<CMD>Telescope telescope-tabs list_tabs<CR>" ,{ desc = "[s]earch [t]abs"})


--------------------------------------------------------------
-- trees/views/explorers
--------------------------------------------------------------
set("n", "<leader>e", "<cmd>NeoTreeFocusToggle<CR>", { desc = "[e]xplorer "})
set("n", "<leader>E", "<cmd>AerialToggle<CR>", { desc = "[E]xplorer summary/outline(aerial)"})
set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[u]ndo tree toggle"})
set("n", "<leader>D", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "[D]iagnostic toggle"}) -- for nvim-dap
set("n", "<leader>N", "<cmd>TroubleToggle todo<CR>", { desc = "[N]otes toggle"}) -- for notes/todo


--------------------------------------------------------------
-- git
------------------------------------------------------------
-- gitsigns
set("n", "[c", "<cmd>Gitsign prev_hunk<cr>", { desc = "prev chunk/change/hunk"})
set("n", "]c", "<cmd>Gitsign next_hunk<cr>", { desc = "next chunk/change/hunk"})
-- diffview
set("n", "<leader>G", "<cmd>DiffviewOpen<cr>", { desc = "open diffview"})


--------------------------------------------------------------
-- nredir
--------------------------------------------------------------
set({"n","v"}, "<leader>!", ":Nredir ", { desc = "[!]execute command and redirect output to sidebuffer"})


--------------------------------------------------------------
-- vim-shell-executor
--------------------------------------------------------------
set("n", "<leader>R", "<cmd>ExecuteBuffer<cr>", { desc = "[R]un buffer"})
set("v", "<leader>R", "<cmd>ExecuteSelection<cr>", { desc = "[R]un selection"})


--------------------------------------------------------------
-- zetelkasten
--------------------------------------------------------------
set("n","<leader>zn","<cmd>Telekasten new_note<cr>",{desc = "[z]ettelkasten [n]ote"})
set("n","<leader>zN","<cmd>Telekasten new_templated_note<cr>",{desc = "[z]ettelkasten [N]ote templated"})
set("n","<leader>zf","<cmd>Telekasten find_notes<cr>",{desc = "[z]ettelkasten [f]ind"})
set("n","<leader>zs","<cmd>Telekasten find_notes<cr>",{desc = "[z]ettelkasten [s]earch"})
set("n","<leader>zg","<cmd>Telekasten search_notes<cr>")
set("n","<leader>zt","<cmd>Telekasten show_tags<cr>",{desc = "[z]ettelkasten [t]ag"})
set("n","<leader>zv","<cmd>Telekasten switch_vault<cr>",{desc = "[z]ettelkasten [v]ault"})
-- set("i","<leader>[[","<esc><cmd>Telekasten insert_link<cr>",{desc = "insert link"})
-- set("n","<leader>z#","<cmd>Telekasten show_tags<cr>")
-- set("n","<leader>zb","<cmd>Telekasten show_backlinks<cr>")
-- set("n","<leader>zF","<cmd>Telekasten find_friends<cr>")
-- set("n","<leader>zd","<cmd>Telekasten find_daily_notes<cr>")
-- set("n","<leader>zz","<cmd>Telekasten follow_link<cr>")
-- set("n","<leader>zT","<cmd>Telekasten goto_today<cr>")
-- set("n","<leader>zW","<cmd>Telekasten goto_thisweek<cr>")
-- set("n","<leader>zw","<cmd>Telekasten find_weekly_notes<cr>")
-- set("n","<leader>zy","<cmd>Telekasten yank_notelink<cr>")
-- set("n","<leader>zc","<cmd>Telekasten show_calendar<cr>")
-- set("<leader>zi",":lua require('telekasten').paste_img_and_link()<CR>)
-- set("n","<leader>zI","<cmd>Telekasten insert_img_link({ i=true })<cr>")
-- set("n","<leader>zp","<cmd>Telekasten preview_img<cr>")
-- set("n","<leader>zm","<cmd>Telekasten browse_media<cr>")
-- set("<leader>zt",":lua require('telekasten').toggle_todo()<CR>)
 -- vnoremap <leader>zt :lua require('telekasten').toggle_todo({ v = true })<CR>
-- set("n","<leader>zC",":CalendarT<CR>)


--------------------------------------------------------------
-- overseer
--------------------------------------------------------------
set("n","<leader>Tt","<cmd>OverseerToggle<cr>",{desc = "[T]ask [t]oggle"})
set("n","<leader>Ti","<cmd>OverseerInfo<cr>",{desc = "[T]ask [i]nfo"})
set("n","<leader>Te","<cmd>OverseerToggle<cr>",{desc = "[T]ask [e]xplorer"})
set("n","<leader>Tr","<cmd>OverseerRun<cr>",{desc = "[T]ask [r]un"})
set("n","<leader>TR","<cmd>OverseerRunCmd<cr>",{desc = "[T]ask [R]un"})
set("n","<leader>Tl","<cmd>OverseerRestartLast<cr>",{desc = "[T]ask [l]ast"})


--------------------------------------------------------------
-- neotest
--------------------------------------------------------------
set("n","<leader>tR",'<cmd>lua require("neotest").run.run({ suite= true})<cr>',{desc = "[t]est [R]un all/suite"})
set("n","<leader>tr","<cmd>Neotest run<cr>",{desc = "[t]est [r]un"})
set("n","<leader>ts","<cmd>Neotest summary<cr>",{desc = "[t]est [r]un"})


--------------------------------------------------------------
-- IconPicker
--------------------------------------------------------------
set("n","<A-i>","<cmd>IconPickerNormal<cr>",{desc = "[i]con"})
set("i","<A-i>","<cmd>IconPickerInsert<cr>",{desc = "[i]con"})


--------------------------------------------------------------
-- Treesj
--------------------------------------------------------------
set("n","<leader>j","<cmd>lua require('treesj').toggle()<cr>",{desc = "toggle split/joint of code block"})


--------------------------------------------------------------
-- nvim-ufo
--------------------------------------------------------------
set("n","zR", require("ufo").openAllFolds, {desc = "open all folds"})
set("n","zM", require("ufo").closeAllFolds, {desc = "close all folds"})
