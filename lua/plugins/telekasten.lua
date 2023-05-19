local ok, telekasten = pcall(require, "telekasten")
if not ok then
	vim.notify("telekasten config not loaded")
	return
end

local zettelkasten_dir = vim.g.knowledgebase_dir .. "/zettelkasten"
local template_dir = vim.env.HOME .. "/Templates/zettelkasten"

telekasten.setup({
	home = zettelkasten_dir,   -- path to main notes folder
	daily = zettelkasten_dir,  -- path to daily notes
	weekly = zettelkasten_dir, -- path to weekly notes
	templates = template_dir,  -- path to templates

	template_new_note = template_dir .. "/note.md",          -- template for new notes
	template_new_daily = template_dir .. "/daily_note.md",   -- template for new daily notes
	template_new_weekly = template_dir .. "/weekly_note.md", -- template for new weekly notes

	-- image subdir for pasting or nil if pasted images shouldn't go into a special subdir
	image_subdir = vim.g.knowledgebase_dir .. "/img",

	extension = ".md",  -- File extension for note files

	-- Generate note filenames. One of:
	-- "title" (default) - Use title if supplied, uuid otherwise
	-- "uuid" - Use uuid
	-- "uuid-title" - Prefix title by uuid
	-- "title-uuid" - Suffix title with uuid
	new_note_filename = "title",
	uuid_type = "%Y%m%d%H%M", -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
	uuid_sep = "-",           -- UUID separator

	-- Flags for creating non-existing notes
	follow_creates_nonexisting = true,  -- create non-existing on follow
	dailies_create_nonexisting = true,  -- create non-existing dailies
	weeklies_create_nonexisting = true, -- create non-existing weeklies
	rename_update_links = true,         -- if `true` update links after a file has been renamed

	-- Image link style",
	-- wiki:     ![[image name]]
	-- markdown: ![](image_subdir/xxxxx.png)
	image_link_style = "wiki",

	sort = "filename",  -- Default sort option: 'filename', 'modified'

	-- Make syntax available to markdown buffers and telescope previewers
	install_syntax = true,

	-- Tag notation: '#tag', ':tag:', 'yaml-bare'
	tag_notation = "#tag",

	-- When linking to a note in subdir/, create a [[subdir/title]] link
	-- instead of a [[title only]] link
	subdirs_in_links = true,

	-- Command palette theme: dropdown (window) or ivy (bottom panel)
	command_palette_theme = "ivy",

	-- Tag list theme:
	-- get_cursor: small tag list at cursor; ivy and dropdown like above
	show_tags_theme = "ivy",

	-- Previewer for media files (images mostly)
	-- "telescope-media-files" if you have telescope-media-files.nvim installed
	-- "catimg-previewer" if you have catimg installed
	-- "viu-previewer" if you have viu installed
	media_previewer = "telescope-media-files",

	-- Calendar integration
	plug_into_calendar = true, -- use calendar integration
	calendar_opts = {
		weeknm = 4, -- calendar week display mode:
		--   1 .. 'WK01'
		--   2 .. 'WK 1'
		--   3 .. 'KW01'
		--   4 .. 'KW 1'
		--   5 .. '1'

		calendar_monday = 1, -- use monday as first day of week:
		--   1 .. true
		--   0 .. false

		calendar_mark = "left-fit", -- calendar mark placement
		-- where to put mark for marked days:
		--   'left'
		--   'right'
		--   'left-fit'
	},

	vaults = {
		wiki = {
			home =vim.g.knowledgebase_dir .. "/wiki",
	        templates = template_dir,
	        template_new_note = template_dir .. "/note.md",
		},
	},

})
