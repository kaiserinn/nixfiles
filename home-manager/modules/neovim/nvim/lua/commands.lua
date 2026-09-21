local term = require("term")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.hl_op({ higroup = "Visual", timeout = 300 })
    end,
    group = highlight_group,
    pattern = "*",
})

vim.api.nvim_create_user_command("Run", function(opts)
    local cmd = opts.args
    if cmd == "" then
        return
    end
    term.run(cmd, { auto_resize = true })
end, { nargs = "*", complete = "shellcmd" })

vim.api.nvim_create_user_command("Runx", function(opts)
    local cmd = opts.args
    if cmd == "" then
        return
    end
    term.run(cmd, { auto_resize = true, close_on_exit = true })
end, { nargs = "*", complete = "shellcmd" })

vim.api.nvim_create_user_command("InsertDate", function()
    local date = os.date("%d/%m/%Y") --[[@as string]]
    vim.api.nvim_put({ date }, "c", true, true)
end, {
    desc = "Insert current date in dd/mm/yyyy format",
})
