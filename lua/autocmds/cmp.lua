-- autocmds below add more sources but default sources still works

local cmp_group = vim.api.nvim_create_augroup("Cmp",{clear = true})


-- add neovim api source to lua files
--vim.api.nvim_create_autocmd("FileType",{
--    desc = "assign aditional sources to lua filetype",
--    group = cmp_group,
--    pattern = "lua",
--    callback = function ()
--        local status_ok , cmp = pcall(require,"cmp")
--        if not status_ok then
--            vim.notify("failed to load cmp in autocmd" .. vim.fn.expand("%"))
--            return
--        end
--
--        cmp.setup.buffer({
--            sources = {
--                {name = "nvim_lua"},
--            }
--        })
--    end
--})

-- vim.cmd [[augroup Cmp au! autocmd FileType sql,mysql,plsql
-- lua require('cmp').setup.buffer { sources = { {name = "vim-dadbod-completion" } }}
-- ]]

-- add DadBodSql source to sql files
-- local DadBodSql = vim.api.nvim_create_augroup("DadBodSql",{clear = true})
--vim.api.nvim_create_autocmd("DadBodSql",{
--    desc = "assign aditional sources to lua filetype",
--    group = DadBodSql,
--    pattern = {"sql","mysql","plsql"},
--    command = function () require("cmp").setup.buffer({
--        sources = {{ name = "vim-dadbod-completion" }}
--    })
--    end
--})
