local ok, null_ls = pcall(require,"null-ls")
if not ok then
    vim.notify("null-ls config not loaded")
    return
end


--- @help {none-ls}
null_ls.setup({
    sources = {

        -- snippet engine for neovim, written in lua
        null_ls.builtins.completion.luasnip,

        -- spell
        null_ls.builtins.completion.spell,
        -- null_ls.builtins.completion.spell -- spell completion
        -- null_ls.builtins.diagnostics.typos,
        -- null_ls.builtins.diagnostics.codespell -- spell diagnostics
        -- null_ls.builtins.diagnostics.proselint -- prose linter


        --------------------------------------
        -- languaje
        --------------------------------------

        -- solidity
        null_ls.builtins.diagnostics.solhint,
        null_ls.builtins.formatting.forge_fmt,

        -- js
        -- { null_ls.builtins.diagnostics.eslint_d }

        -- sh
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt,

        --lua
        -- null_ls.builtins.diagnostics.selene,
        -- null_ls.builtins.formatting.lua_format,

        -- md
        -- null_ls.builtins.diagnostics.markdownlint,

        -- go
        -- null_ls.builtins.code_actions.gomodifytags, -- modify tags
        -- null_ls.builtins.code_actions.impl,         -- impl generates method stubs for implementing an interface.
        -- { null_ls.builtins.diagnostics.golangci_lint } -- go linter aggregator
        -- { null_ls.builtins.diagnostics.staticcheck }
        -- { null_ls.builtins.formatting.gofmt }
        -- { null_ls.builtins.formatting.goimports }
        -- { null_ls.builtins.formatting.goimports_reviser }

        -- latex
        -- { null_ls.builtins.diagnostics.chktex } -- latex semantic checker

        -- json/yaml/toml
        -- null_ls.builtins.diagnostics.spectral,
        -- null_ls.builtins.formatting.taplo,
        -- null_ls.builtins.formatting.jq

        --------------------------------------
        -- tools
        --------------------------------------

        -- null_ls.builtins.diagnostics.editorconfig_checker, -- editorconfig checker
        -- null_ls.builtins.diagnostics.todo_comments,
        -- null_ls.builtins.code_actions.gitsigns,            -- git rebase
        -- null_ls.builtins.diagnostics.dotenv_linter,        -- dotenv linter
        -- null_ls.builtins.diagnostics.checkmake,            -- make linter
        -- null_ls.builtins.diagnostics.gitlint,              -- git commit messages linter
        -- { null_ls.builtins.code_actions.ts_node_action } -- a framework for running functions on Tree-sitter nodes, and updating the buffer with the result.
        -- { null_ls.builtins.code_actions.refactoring }

    },
})
