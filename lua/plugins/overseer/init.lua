local status_ok, overseer = pcall(require, "overseer")
if not status_ok then
	vim.notify("overseer config not loaded")
	return
end

local files = require("overseer.files")

-- local generate_templates_for = function(template_name)
--      local templates = {}
--
--      local templates_path = string.format(
--         "%s/lua/plugins/overseer/template/%s",
--         vim.fn.stdpath('config'),
--         template_name
--      )
--      for module in vim.fs.dir(templates_path) do
--         local template = string.format("%s.%s",template_name,module)
--         vim.notify(template)
--         table.insert(templates,template)
--      end
--
--     return templates
-- end


--- @doc {overseer-options}
overseer.setup({
	strategy = "terminal",
	templates = { "builtin" },
	auto_detect_success_color = true,
	dap = true,
	task_list = {
		default_detail = 1,
		max_width = { 100, 0.2 },
		min_width = { 40, 0.1 },
		width = nil,
		separator = "────────────────────────────────────────",
		direction = "left",
		bindings = {
			["?"] = "ShowHelp",
			["<CR>"] = "RunAction",
			["<C-e>"] = "Edit",
			["o"] = "Open",
			["<C-v>"] = "OpenVsplit",
			["<C-s>"] = "OpenSplit",
			["<C-f>"] = "OpenFloat",
			["<C-q>"] = "OpenQuickFix",
			["p"] = "TogglePreview",
			["<C-l>"] = "IncreaseDetail",
			["<C-h>"] = "DecreaseDetail",
			["L"] = "IncreaseAllDetail",
			["H"] = "DecreaseAllDetail",
			["["] = "DecreaseWidth",
			["]"] = "IncreaseWidth",
			["{"] = "PrevTask",
			["}"] = "NextTask",
		},
	},
	actions = {},
	form = {
		border = "rounded",
		zindex = 40,
		min_width = 80,
		max_width = 0.9,
		width = nil,
		min_height = 10,
		max_height = 0.9,
		height = nil,
		win_opts = {
			winblend = 10,
		},
	},
	task_launcher = {
		bindings = {
			i = {
				["<C-s>"] = "Submit",
				["<C-c>"] = "Cancel",
			},
			n = {
				["<CR>"] = "Submit",
				["<C-s>"] = "Submit",
				["q"] = "Cancel",
				["?"] = "ShowHelp",
			},
		},
	},
	task_editor = {
		bindings = {
			i = {
				["<CR>"] = "NextOrSubmit",
				["<C-s>"] = "Submit",
				["<Tab>"] = "Next",
				["<S-Tab>"] = "Prev",
				["<C-c>"] = "Cancel",
			},
			n = {
				["<CR>"] = "NextOrSubmit",
				["<C-s>"] = "Submit",
				["<Tab>"] = "Next",
				["<S-Tab>"] = "Prev",
				["q"] = "Cancel",
				["?"] = "ShowHelp",
			},
		},
	},
	confirm = {
		border = "rounded",
		zindex = 40,
		min_width = 20,
		max_width = 0.5,
		width = nil,
		min_height = 6,
		max_height = 0.9,
		height = nil,
		win_opts = {
			winblend = 10,
		},
	},
	task_win = {
		padding = 2,
		border = "rounded",
		win_opts = {
			winblend = 10,
		},
	},
	component_aliases = {
		default = {
			{ "display_duration", detail_level = 2 },
			"on_output_summarize",
			"on_exit_set_status",
			"on_complete_notify",
			"on_complete_dispose",
		},
		default_vscode = {
			"default",
			"on_result_diagnostics",
			"on_result_diagnostics_quickfix",
		},
        default_neotest = {
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          "on_complete_dispose",
      }
	},
	bundles = {
		save_task_opts = {
			bundleable = true,
		},
	},
	preload_components = {},
	default_template_prompt = "allow",
	template_timeout = 3000,
	template_cache_threshold = 100,
	log = {
		{
			type = "echo",
			level = vim.log.levels.WARN,
		},
		{
			type = "file",
			filename = "overseer.log",
			level = vim.log.levels.WARN,
		},
	},
})

local tmpl = {
    name = "run scripts",
    builder = function(params)
        return {
            cmd = 'ls',
            args = { "$HOME/Code/Scripts" },
        }
    end,
    desc = "Optional description of task",
}

overseer.register_template(tmpl)

overseer.register_template({
  generator = function(search, cb)
        cb({
            overseer.wrap_template(tmpl,nil)
        })
  end,
  condition = function(search)
    return true
  end,
})

-- function register_scripts_templates()
--     local scripts_dir = vim.g.scripts_dir
--
--     local scripts = vim.tbl_filter(
--         function(filename) return filename:match("%.sh$") end,
--         files.list_files(scripts_dir)
--     )
--
--     for _, filename in ipairs(scripts) do
--
--         overseer.register_template({
--             name = string.format("script %s",filename),
--             -- args = {
--             --     args = { optional = true, type = "list", delimiter = " " },
--             -- },
--             builder = function(params)
--                 return {
--                     cmd = { "sh" },
--                     args = {
--                         files.join(scripts_dir,filename),
--                         params.args
--                     } ,
--                 }
--             end,
--         })
--
--     end
-- end
-- register_scripts_templates()



-- overseer.register_template({
--     generator =  function(opts, callback)
--         -- local scripts = vim.tbl_filter(
--         --     function(filename) return filename:match("%.sh$") end,
--         --     files.list_files(opts.dir)
--         -- )
--         local scripts = vim.tbl_filter(
--             function(filename) return filename:match("%.sh$") end,
--             files.list_files(vim.g.scripts_dir)
--         )
--         vim.notify(opts)
--
--         local ret = {}
--         for _, filename in ipairs(scripts) do
--             table.insert(ret, {
--                 name = filename,
--                 params = {
--                     args = { optional = true, type = "list", delimiter = " " },
--                 },
--                 builder = function(params)
--                     return {
--                         cmd = { files.join(opts.dir, filename) },
--                         args = params.args,
--                     }
--                 end,
--             })
--         end
--
--         callback(ret)
--     end
-- })
