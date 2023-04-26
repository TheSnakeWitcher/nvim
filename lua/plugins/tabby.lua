local status_ok, tabline = pcall(require, "tabby.tabline")
if not status_ok then
	vim.notify("tabby tabline config not loaded")
	return
end


--local function tab_label(tabid, active)
--  local icon = active and '' or ''
--  local number = vim.api.nvim_tabpage_get_number(tabid)
--  local name = util.get_tab_name(tabid)
--  return string.format(' %s %d: %s ', icon, number, name)
--end


--local palettes = {
--  gruvbox_light = {
--    accent = '#d65d0e', -- orange
--    accent_sec = '#7c6f64', -- fg4
--    bg = '#ebdbb2', -- bg1
--    bg_sec = '#d5c4a1', -- bg2
--    fg = '#504945', -- fg2
--    fg_sec = '#665c54', -- fg3
--  },
--  gruvbox_dark = {
--    accent = '#d65d0e', -- orange
--    accent_sec = '#a89984', -- fg4
--    bg = '#3c3836', -- bg1
--    bg_sec = '#504945', -- bg2
--    fg = '#d5c4a1', -- fg2
--    fg_sec = '#bdae93', -- fg3
--  },
--  edge_light = {
--    accent = '#bf75d6', -- bg_purple
--    accent_sec = '#8790a0', -- grey
--    bg = '#eef1f4', -- bg1
--    bg_sec = '#dde2e7', -- bg4
--    fg = '#33353f', -- default:bg1
--    fg_sec = '#4b505b', -- fg
--  },
--  nord = {
--    accent = '#88c0d0', -- nord8
--    accent_sec = '#81a1c1', -- nord9
--    bg = '#3b4252', -- nord1
--    bg_sec = '#4c566a', -- nord3
--    fg = '#e5e9f0', -- nord4
--    fg_sec = '#d8dee9', -- nord4
--  },
--}
--
--local tabby_config = function()
--  local palette = palettes.gruvbox_dark
--  local filename = require('tabby.filename')
--  local cwd = function()
--    return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
--  end
--  local tabname = function(tabid)
--    return vim.api.nvim_tabpage_get_number(tabid)
--  end
--  local line = {
--    hl = { fg = palette.fg, bg = palette.bg },
--    layout = 'active_wins_at_tail',
--    head = {
--      { cwd, hl = { fg = palette.bg, bg = palette.accent } },
--      { '', hl = { fg = palette.accent, bg = palette.bg } },
--    },
--    active_tab = {
--      label = function(tabid)
--        return {
--          '  ' .. tabname(tabid) .. ' ',
--          hl = { fg = palette.bg, bg = palette.accent_sec, style = 'bold' },
--        }
--      end,
--      left_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--      right_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--    },
--    inactive_tab = {
--      label = function(tabid)
--        return {
--          '  ' .. tabname(tabid) .. ' ',
--          hl = { fg = palette.fg, bg = palette.bg_sec, style = 'bold' },
--        }
--      end,
--      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--    },
--    top_win = {
--      label = function(winid)
--        return {
--          '  ' .. filename.unique(winid) .. ' ',
--          hl = { fg = palette.fg, bg = palette.bg_sec },
--        }
--      end,
--      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--    },
--    win = {
--      label = function(winid)
--        return {
--          '  ' .. filename.unique(winid) .. ' ',
--          hl = { fg = palette.fg, bg = palette.bg_sec },
--        }
--      end,
--      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
--    },
--    tail = {
--      { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
--      { '  ', hl = { fg = palette.bg, bg = palette.accent_sec } },
--    },
--  }
--  require('tabby').setup({ tabline = line })
--end
--
--tabby_config()

--local presets = {
--  hl = 'lualine_c_normal',
--  layout = 'tab_only',
--  head = {
--    { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
--    { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--  },
--  active_tab = {
--    label = function(tabid)
--      return {
--        tab_label(tabid, true),
--        hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
--      }
--    end,
--    left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
--    right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
--  },
--  inactive_tab = {
--    label = function(tabid)
--      return {
--        tab_label(tabid, false),
--        hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
--      }
--    end,
--    left_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--    right_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
--  },
--}

local theme = {
	fill = "TabLineFill",
	head = "TabLine",
	current_tab = "TabLineSel",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}

tabline.set(function(line) return {
		{
			{ "  ", hl = theme.head },
			line.sep("", theme.head, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			return {
				line.sep("", hl, theme.fill),
				tab.is_current() and '' or '',
				tab.number(),
				tab.name(),
				tab.close_btn(""),
				line.sep("", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			return {
				line.sep("", theme.win, theme.fill),
				win.is_current() and "●" or "",
				win.buf_name(),
				line.sep("", theme.win, theme.fill),
				hl = theme.win,
				margin = " ",
			}
		end),
		{
			line.sep("", theme.tail, theme.fill),
			{ "  ", hl = theme.tail },
		},
		hl = theme.fill,
	}
end)
