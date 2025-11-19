--- @help {vim.keymap}
--- @help {key-notation}
-- TODO: very important, try defining keymaps that is {bufnr}B to jump to the corresponding buffer 
--       that should only be feasible using a sidebar with open buffers

local set = vim.keymap.set
local opts = { noremap = true, silent = true }


--------------------------------------------------------------
-- custom operators
--------------------------------------------------------------
local ok , yop = pcall(require,"yop")
if not ok then
    vim.notify("yop not loaded in keymaps")
else
    yop.op_map({"n", "v"}, "<leader>h", function(lines, info)
        vim.cmd(string.format("help %s",lines[1]))
    end)

    yop.op_map("v", "<leader>fg", function(lines, info)
        if #lines > 1 then return end
        vim.cmd(string.format("Telescope grep_string search=%s",lines[1]))
    end, { desc = '[f]ind [g]rep' })
end


--------------------------------------------------------------
-- builtins
--------------------------------------------------------------
-- set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
set("i", "<C-c>", "<Esc>", { silent = true })
-- set("v", "S", ":s/\v/g<LEFT><LEFT>",{desc = "substitute pattern in range globally"})

-- terminal
set("t", "<C-c>", "<Esc>", { silent = true })

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
set({"v","x"}, "<leader>p", "\"_dP", { desc = "delete without copy selected content and paste"})
set({"n","v"}, "<leader>d", "\"_d", { desc = "delete to hold register"})
set({"n","v"}, "<leader>y", "\"+y", { desc = "copy to system clipboard"})
set("n", "<leader>Y", "\"+Y", { desc = "copy to system clipboard entire line"})


--------------------------------------------------------------
-- center search results 
--------------------------------------------------------------
set("n", "n", "nzz")
set("n", "N", "Nzz")


--------------------------------------------------------------
-- navigations
--------------------------------------------------------------
-- go to
set("n","gl", "<cmd>norm gx<cr>", opts)

-- tabs
set("n", "<S-l>", ":tabnext<CR>", opts)
set("n", "<S-h>", ":tabprev<CR>", opts)

-- windows
set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-l>", "<C-w>l", opts)

-- detour
set("n", "<C-w>f", "<cmd>Detour<cr>", { desc = "float global window" })
set("n", "<C-w>F", "<cmd>DetourCurrentWindow<cr>", { desc = "float local window" })
set("n", "<C-w><C-f>", "<cmd>Detour<cr>", { desc = "float global window" })
set("n", "<C-w><C-F>", "<cmd>DetourCurrentWindow<cr>", { desc = "float local window" })


--------------------------------------------------------------
-- resize windows with arrows
--------------------------------------------------------------
set("n", "<C-Up>", ":resize -10<CR>", opts)
set("n", "<C-Down>", ":resize +10<CR>", opts)
set("n", "<C-Left>", ":vertical resize -10<CR>", opts)
set("n", "<C-Right>", ":vertical resize +10<CR>", opts)


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
set('n', '<leader>/', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { desc = '[/] Fuzzily search in current buffer]' })
set("n" , "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { desc = "[f]ind [h]elp" })
set("n" , "<leader>fM", "<cmd>lua require('telescope.builtin').man_pages()<cr>", { desc = "[f]ind [M]an pages" })
set("n" , "<leader>fm", "<cmd>lua require('telescope.builtin').marks()<cr>", { desc = "[f]ind [m]arks" })
set("n" , "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>", { desc = "[f]ind [r]registers" })
set("n" , "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", { desc = "[f]ind [k]eymaps" })
set("n" , "<leader>fC", "<cmd>lua require('telescope.builtin').command_history()<cr>", { desc = "[f]ind [c]ommand history" })

set("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", { desc = "[f]ind [d]iagnostics" })
set("n", "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", { desc = "[f]ind [q]uickfix" })
set("n", "<leader>fp", "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') })<cr>", { desc = "[f]ind [p]lugins files" })

-- file pickers
set("n", "<C-f>", "<cmd> lua require('telescope.builtin').git_files()<cr>", { desc = "[f]ind [g]itfiles(tracked by git according to .gitignore)" })
set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "[f]ind [f]iles" })
set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = "[f]ind [g]rep"  })
-- set("n", "<leader>fG", "<cmd>lua require('telescope.builtin').live_grep grep_open_files=true()<cr>", { desc = "[f]ind [G]rep"  })
set("n", "<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>",{ desc = "[f]ind [o]ldfiles" })
set("n", "<leader>fP", "<cmd>lua require('telescope').extensions.lazy.lazy()<cr>", { desc = "[f]ind [P]lugins" })

-- git pickers
set("n", "<C-s>", "<cmd>lua require('telescope.builtin').git_status()<cr>", { desc = "[f]ind [S]tatus" })
set("n","<leader>fs","<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { desc = "[f]ind [S]tatus" })
set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", { desc = "[f]ind [b]ranches" })
set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", { desc = "[f]ind [c]ommits" })
set("n", "<leader>B", "<cmd>lua require('telescope.builtin').buffers({ sort_mru=true, sort_lastused=true, initial_mode=normal, theme=ivy})<cr>", { desc = "[f]ind [B]uffers" })
set("n", "<C-b>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru=true, sort_lastused=true, initial_mode=normal, theme=ivy})<cr>", { desc = "[f]ind [B]uffers" })

-- extensions pickers
set("n", "<C-p>", "<cmd>lua require('telescope').extensions.projections.projections()<CR>", { desc = "[f]ind [p]rojects" })
set("n", "<leader>fn", "<cmd>lua require('telescope').extensions['todo-comments'].todo()<CR>", { desc = "[f]ind [n]otes" })
set("n", "<leader>fN", "<cmd>lua require('snacks.notifier').show_history()<CR>", { desc = "[f]ind [N]otifications" })
set("n", "<leader>fe", "<cmd>lua require('telescope').extensions.env.env()<CR>", { desc = "[f]ind [e]nvironment" })
set("n", "<leader>ft", "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs()<CR>", { desc = "[f]ind [t]abs" })
set("n", "<leader>fH", "<cmd>lua require('telescope').extensions.heading.heading()<cr>", { desc = "[f]ind [H]eaders" })
set("n", "<leader>fz", "<cmd>lua require('telescope').extensions.zoxide.list()<cr>", { desc = "[f]ind [z]oxide" })


--------------------------------------------------------------
-- Diagnostic keymaps
--------------------------------------------------------------
-- TODO: changed api, use vim.diagnostic.jump
-- set('n', '[d', vim.diagnostic.goto_prev, { noremap = true , desc = "next diagnostic"})
-- set('n', ']d', vim.diagnostic.goto_next, { noremap = true , desc = "next diagnostic"})
-- set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts)
-- set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts)
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "[q]uickfix set loclist" })


--------------------------------------------------------------
-- luasnip
--------------------------------------------------------------
set("n", "<leader>fS", "<CMD>LuaSnipEdit<CR>" , { desc = "[f]ind [s]snippets", silent = true })
set({"i","s"},"<C-s>",function()
    if require('luasnip').choice_active() then
        require('luasnip.extras.select_choice')()
    end
end,{desc = "select choice" , silent = true})


--------------------------------------------------------------
-- buffer_manager
--------------------------------------------------------------
for key = 1, 9 do
    set('n', string.format('<A-%d>', key), string.format('<cmd>lua require("buffer_manager.ui").nav_file(%d)<cr>', key), { desc = "go to buffer " .. key  })
end


--------------------------------------------------------------
-- urlview
--------------------------------------------------------------
set("n", "<leader>fu", "<cmd>UrlView buffer<cr>", { desc = "[f]ind [u]rls in buffer" })


--------------------------------------------------------------
-- tab management
--------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { desc = "create new tab",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tq", ":tabclose<CR>", {desc = "close selected tab", noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { desc = "close all tabs except selected",noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { desc = "select next tab",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { desc = "select previous tab",noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { desc = "move current tab to next position",noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { desc = "move current tab to previous position" , noremap = true })

set("n", "<leader>tl", "<CMD>Telescope telescope-tabs list_tabs<CR>", { desc = "[f]ind [t]abs" })


--------------------------------------------------------------
-- trees/views/explorers
--------------------------------------------------------------
-- set("n", "<leader>e", '<cmd>lua require("edgy").toggle("left")<CR>', { desc = "[e]xplorers(edgy)" })
set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "[e]xplorer" })
set("n", "<leader>E", "<cmd>AerialToggle<CR>", { desc = "[E]xplorer summary/outline(aerial)" })
set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[u]ndo tree toggle" })
set("n", "<leader>D", "<cmd>Trouble diagnostics toggle <CR>", { desc = "[D]iagnostic toggle" })
set("n", "<leader>Q", "<cmd>Trouble quickfix toggle<CR>", { desc = "[Q]uickfix toggle" })
set("n", "<leader>N", "<cmd>Trouble todo toggle<CR>", { desc = "[N]otes toggle" })


--------------------------------------------------------------
-- git
------------------------------------------------------------
-- gitsigns
set("n", "[c", "<cmd>Gitsign prev_hunk<cr>", { desc = "prev change/chunk/hunk" })
set("n", "]c", "<cmd>Gitsign next_hunk<cr>", { desc = "next change/chunk/hunk" })
-- set("n", "<leader>g", "<cmd>Gitsign setloclist<cr>", { desc = "add current changes to loclist" })
set("n", "<leader>g", "<cmd>G difftool<cr>", { desc = "add current changes to quickfix" })
-- diffview
set("n", "<leader>G", "<cmd>DiffviewOpen<cr>", { desc = "open diffview" })
set("n", "<leader>Gv", "<cmd>GV --all<cr>", { desc = "git viewer all" })


--------------------------------------------------------------
-- nredir
--------------------------------------------------------------
set({"n","v"}, "<leader>!", ":Nredir ", { desc = "[!]execute command and redirect output to sidebuffer" })


--------------------------------------------------------------
-- knowledgebase/zettelkasten
--------------------------------------------------------------
set("n", "<leader>zn", "<cmd>Obsidian new<cr>", { desc = "[z]ettelkasten [n]ote" })
set("n", "<leader>zN", "<cmd>Obsidian template<cr>", { desc = "[z]ettelkasten [N]ote templated" })
set("n", "<leader>zf", "<cmd>Obsidian search<cr>", { desc = "[z]ettelkasten [F]ind" })
set("n", "<leader>zF", "<cmd>Obsidian quick_switch<cr>", { desc = "[z]ettelkasten [f]ind" })
set("n", "<leader>zt", "<cmd>Obsidian tags<cr>", { desc = "[z]ettelkasten [t]ag" })
set("n", "<leader>zl", "<cmd>Obsidian links<cr>", { desc = "[z]ettelkasten [l]inks" })
set("n", "<leader>zb", "<cmd>Obsidian backlinks<cr>", { desc = "[z]ettelkasten [l]inks" })
set("n", "<leader>zv", "<cmd>Obsidian workspace<cr>", { desc = "[z]ettelkasten [v]ault" })


--------------------------------------------------------------
-- overseer
--------------------------------------------------------------
set("n", "<leader>Tt", "<cmd>OverseerToggle<cr>", { desc = "[T]ask [t]oggle" })
set("n", "<leader>Ti", "<cmd>OverseerInfo<cr>", { desc = "[T]ask [i]nfo" })
set("n", "<leader>Te", "<cmd>OverseerToggle<cr>", { desc = "[T]ask [e]xplorer" })
set("n", "<leader>Tr", "<cmd>OverseerRun<cr>", { desc = "[T]ask [r]un" })
set("n", "<leader>TR", "<cmd>OverseerRunCmd<cr>", { desc = "[T]ask [R]un" })
set("n", "<leader>Tl", "<cmd>OverseerRestartLast<cr>", { desc = "[T]ask [l]ast" })


--------------------------------------------------------------
-- neotest
--------------------------------------------------------------
set("n", "<leader>tR", '<cmd>lua require("neotest").run.run({ suite= true})<cr>', { desc = "[t]est [R]un all/suite" })
set("n", "<leader>tr", "<cmd>Neotest run<cr>", { desc = "[t]est [r]un" })
set("n", "<leader>ts", "<cmd>Neotest summary<cr>", { desc = "[t]est [s]umary" })
-- set("n", "]t", '<cmd>lua require("neotest").jump.next({ status = "failed" })<cr>', { desc = "next failed test" })
-- set("n", "[t", '<cmd>lua require("neotest").jump.prev({ status = "failed" })<cr>', { desc = "prev failed test" })


--------------------------------------------------------------
-- Treesj
--------------------------------------------------------------
set("n", "<leader>j", "<cmd>lua require('treesj').toggle()<cr>", { desc = "toggle split/joint of code block"})


--------------------------------------------------------------
-- nvim-ufo
--------------------------------------------------------------
set("n", "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", { desc = "open all folds" })
set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", { desc = "close all folds" })
