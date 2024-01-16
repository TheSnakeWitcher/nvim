local ok, tabline = pcall(require, "tabby.tabline")
if not ok then
	vim.notify("tabby tabline config not loaded")
	return
end

local theme = {
	fill = "TabLineFill",
	head = "TabLine",
	current_tab = "TabLineSel",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}

---@help {tabby-setup-setup-tabby.nvim}
tabline.set(function(line) return {
	{
		{ "  ", hl = theme.head },
		line.sep("", theme.head, theme.fill),
	},
	line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
		return {
			line.sep("", theme.win, theme.fill),
			win.is_current() and "●" or "",
			win.buf_name(),
			line.sep("", theme.win, theme.fill),
			hl = theme.win,
			margin = " ",
		}
	end),
	line.spacer(),
	line.tabs().foreach(function(tab)
		local hl = tab.is_current() and theme.current_tab or theme.tab
		return {
			line.sep("", hl, theme.fill),
			tab.number(),
			tab.name(),
			tab.close_btn(""),
			line.sep("", hl, theme.fill),
			hl = hl,
			margin = " ",
		}
	end),
	-- {
	-- 	line.sep("", theme.tail, theme.fill),
	-- 	{ "  ", hl = theme.tail },
	-- },
	hl = theme.fill,
}
end)

--- TODO: change toggleterm and neotree windows name


-- https://github.com/nanozuki/tabby.nvim/discussions/106
-- function tab_name(tab) 
--    return string.gsub(tab,"%[..%]","") 
-- end
--
--
-- function tab_modified(tab)
--     wins = require("tabby.module.api").get_tab_wins(tab)
--     for i, x in pairs(wins) do
--         if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
--             return ""
--         end
--     end
--     return ""
-- end
--
-- function lsp_diag(buf) 
--     diagnostics = vim.diagnostic.get(buf)
--     local count = {0, 0, 0, 0}
--     
--     for _, diagnostic in ipairs(diagnostics) do
--         count[diagnostic.severity] = count[diagnostic.severity] + 1
--     end
--     if count[1] > 0 then
--         return vim.bo[buf].modified and "" or ""
--     elseif count[2] > 0 then 
--         return vim.bo[buf].modified and "" or ""
--     end
--     return vim.bo[buf].modified and "" or ""
-- end 
--
-- local function get_modified(buf)
--     if vim.bo[buf].modified then
--         return ''
--     else
--         return ''
--     end
-- end
--
-- local function buffer_name(buf)
--     if string.find(buf,"NvimTree") then 
--         return "NvimTree"
--     end
--     return buf
-- end
--
-- local theme = {
--   fill = 'TabFill',
--   -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
--   head = 'TabLineHead',
--   current_tab = 'TabLineSel',
--   inactive_tab = 'TabLineIn',
--   tab = 'TabLine',
--   win = 'TabLineHead',
--   tail = 'TabLineHead',
-- }
-- require('tabby.tabline').set(function(line)
--   return {
--     {
--       { '  ', hl = theme.head },
--       line.sep('', theme.head, theme.fill),
--     },
--     line.tabs().foreach(function(tab)
--       local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
--       return {
--         line.sep('', hl, theme.fill),
--         tab.number(),
--         "",
--         tab_name(tab.name()),
--         "",
--         tab_modified(tab.id),
--         line.sep('', hl, theme.fill),
--         hl = hl,
--         margin = ' ',
--       }
--     end),
--     line.spacer(),
--     line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
--       local hl = win.is_current() and theme.current_tab or theme.inactive_tab
--       return {
--         line.sep('', hl, theme.fill),
--         win.file_icon(),
--         "",
--         buffer_name(win.buf_name()),
--         "",
--         lsp_diag(win.buf().id),
--         line.sep('', hl, theme.fill),
--         hl = hl,
--         margin = ' ',
--       }
--     end),
--     {
--       line.sep('', theme.tail, theme.fill),
--       { '  ', hl = theme.tail },
--     },
--     hl = theme.fill,
--   }
-- end)


--- https://github.com/nanozuki/tabby.nvim/blob/main/lua/tabby/presets.lua
-- local util = require('tabby.util')
--
-- local hl_tabline_fill = util.extract_nvim_hl('lualine_c_normal') -- 背景
-- local hl_tabline = util.extract_nvim_hl('lualine_b_normal')
-- local hl_tabline_sel = util.extract_nvim_hl('lualine_a_normal') -- 高亮
--
-- local function tab_label(tabid, active)
--   local icon = active and '' or ''
--   local number = vim.api.nvim_tabpage_get_number(tabid)
--   local name = util.get_tab_name(tabid)
--   return string.format(' %s %d: %s ', icon, number, name)
-- end
--
-- local presets = {
--   hl = 'lualine_c_normal',
--   layout = 'tab_only',
--   head = {
--     { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
--     { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--   },
--   active_tab = {
--     label = function(tabid)
--       return {
--         tab_label(tabid, true),
--         hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
--       }
--     end,
--     left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
--     right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
--   },
--   inactive_tab = {
--     label = function(tabid)
--       return {
--         tab_label(tabid, false),
--         hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
--       }
--     end,
--     left_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--     right_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--   },
-- }
--
-- return presets



-- require("tabby").setup({tabline = tabline})
-- local tabby_config = function()
--   local palette = require('features.ui.colors').palette
--   local filename = require('tabby.filename')
--   local cwd = function()
--     return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
--   end
--   local tabname = function(tabid)
--     return vim.api.nvim_tabpage_get_number(tabid)
--   end
--   local line = {
--     hl = { fg = palette.fg, bg = palette.bg },
--     layout = 'active_wins_at_tail',
--     head = {
--       { cwd, hl = { fg = palette.bg, bg = palette.accent } },
--       { '', hl = { fg = palette.accent, bg = palette.bg } },
--     },
--     active_tab = {
--       label = function(tabid)
--         return {
--           '  ' .. tabname(tabid) .. ' ',
--           hl = { fg = palette.bg, bg = palette.accent_sec, style = 'bold' },
--         }
--       end,
--       left_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--       right_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--     },
--     inactive_tab = {
--       label = function(tabid)
--         return {
--           '  ' .. tabname(tabid) .. ' ',
--           hl = { fg = palette.fg, bg = palette.bg_sec, style = 'bold' },
--         }
--       end,
--       left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--       right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--     },
--     top_win = {
--       label = function(winid)
--         return {
--           '  ' .. filename.unique(winid) .. ' ',
--           hl = { fg = palette.fg, bg = palette.bg_sec },
--         }
--       end,
--       left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--       right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--     },
--     win = {
--       label = function(winid)
--         return {
--           '  ' .. filename.unique(winid) .. ' ',
--           hl = { fg = palette.fg, bg = palette.bg_sec },
--         }
--       end,
--       left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--       right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--     },
--     tail = {
--       { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--       { '  ', hl = { fg = palette.bg, bg = palette.accent_sec } },
--     },
--   }
--   require('tabby').setup({ tabline = line })
-- end


