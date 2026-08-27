local term = require("core.term")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_user_command("Run", function(opts)
    local cmd = opts.args
    if cmd == "" then return end
    term.run(cmd, { auto_resize = true })
end, { nargs = "*", complete = "shellcmd" })
