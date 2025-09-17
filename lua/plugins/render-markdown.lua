local  ok, render_markdown = pcall(require,"render-markdown")
if not ok then
    vim.notify "render-markdown config not loaded"
    return
end

--- @help {render-markdown-setup}
render_markdown.setup({
    file_types = { 'markdown', 'Avante' },
    completions = { lsp = { enabled = true } },
    bullet = {
        icons = { '•', '•', '◆', '◇' },
        enabled = true,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
    },
    link = {
        custom = {
            web = { pattern = "^http[s]?://", icon = "󰌷 " , highlight = "RenderMarkdownLink" },
        },
    }
})
