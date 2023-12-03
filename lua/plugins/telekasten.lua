local ok, telekasten = pcall(require, "telekasten")
if not ok then
	vim.notify("telekasten config not loaded")
	return
end


local knowledgebase_dir = vim.g.knowledgebase_dir
local zettelkasten_dir = knowledgebase_dir .. "/zettelkasten"
local template_dir = vim.env.HOME .. "/Templates/zettelkasten"


--- @help {telekasten.setup()}
telekasten.setup({
    home = zettelkasten_dir,
    daily = zettelkasten_dir,
    weekly = zettelkasten_dir,
    templates = template_dir,

	template_new_note = template_dir .. "/note.md",
	template_new_daily = template_dir .. "/daily_note.md",
	template_new_weekly = template_dir .. "/weekly_note.md",
	image_subdir = knowledgebase_dir .. "/img",

	extension = ".md",
	new_note_filename = "title",
	uuid_type = "%Y%m%d%H%M",
	uuid_sep = "-",

	follow_creates_nonexisting = true,
	dailies_create_nonexisting = true,
	weeklies_create_nonexisting = true,
	rename_update_links = true,

	image_link_style = "wiki",

	sort = "filename",
	install_syntax = true,
	tag_notation = "#tag",
	subdirs_in_links = true,
	command_palette_theme = "ivy",
	show_tags_theme = "ivy",
	media_previewer = "telescope-media-files",

	plug_into_calendar = false,
	calendar_opts = {
		weeknm = 4,
		calendar_monday = 1,
		calendar_mark = "left-fit",
	},

	vaults = {
		wiki = {
			home = knowledgebase_dir .. "/wiki",
	        templates = template_dir,
	        template_new_note = template_dir .. "/note.md",
		},
	},

})
