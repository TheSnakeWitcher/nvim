local status_ok, navigator = pcall(require, "navigator")
if not status_ok then
    vim.notify("navigator config not loaded")
    return
end

navigator.setup({

  debug = false,
  width = 0.75,
  height = 0.3,
  preview_height = 0.35,
  border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
  on_attach = function(client, bufnr)
    -- your hook --
  end,

  ts_fold = false,
  default_mapping = true,
  keymaps = {{key = "gK", func = vim.lsp.declaration, desc = 'declaration'}},
  treesitter_analysis = true,
  treesitter_navigation = true,
  treesitter_analysis_max_num = 100,
  treesitter_analysis_condense = true,
  transparency = 50,

  lsp_signature_help = true,
  signature_help_cfg = nil,
  icons = {
    code_action_icon = "🏏",
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = "🈲",
  },
  mason = false,
  lsp = {
    enable = true,
    code_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
    code_lens_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
    document_highlight = true,
    format_on_save = true,
    format_options = {async=false},
    disable_format_cap = {"sqls", "lua_ls", "gopls"},
    -- disable_lsp = {'pylsd', 'sqlls'},  -- prevents navigator from setting up this list of servers. 
    diagnostic = {
      underline = true,
      virtual_text = true,
      update_in_insert = false,
    },

    diagnostic_scrollbar_sign = {'▃', '▆', '█'},
    diagnostic_virtual_text = true,
    diagnostic_update_in_insert = false,
    disply_diagnostic_qf = true,

    tsserver = {
        filetypes = {'typescript'}
    },

    ctags ={
        cmd = 'ctags',
        tagfile = 'tags',
        options = '-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number',
    },

    gopls = {
      on_attach = function(client, bufnr)
        -- e.g. disable gopls format because a known issue https://github.com/golang/go/issues/45732
        print("i am a hook, I will disable document format")
        client.resolved_capabilities.document_formatting = false
      end,
      settings = {
        gopls = {gofumpt = false}
      }
    },

    gopls = function()
      local go = pcall(require, "go")
      if go then
        local cfg = require("go.lsp").config()
        cfg.on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end
        return cfg
      end
    end,

    --lua_ls = {
    --  lua_ls_root_path = vim.fn.expand("$HOME") .. "/github/sumneko/lua-language-server",
    --  lua_ls_binary = vim.fn.expand("$HOME") .. "/github/sumneko/lua-language-server/bin/macOS/lua-language-server",
    --},

    servers = {'cmake', 'ltex'},
  }
})
