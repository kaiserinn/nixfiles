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

vim.api.nvim_create_user_command('Config', function ()
  CurrDir = vim.fn.getcwd()
  local cmd = 'cd ' .. vim.fn.stdpath('config') .. ' | Telescope find_files'
  vim.cmd(cmd)
end, { desc = "Go to config" })

vim.api.nvim_create_user_command('ConfigBack', function ()
  if CurrDir ~= nil then
    local cmd = 'cd ' .. CurrDir .. ' | Telescope find_files'
    CurrDir = nil
    vim.cmd(cmd)
  end
end, { desc = "Go back from config" })

vim.api.nvim_create_user_command('ConfigSearch', function ()
  local cmd = 'Telescope find_files cwd=' .. vim.fn.stdpath("config")
  vim.cmd(cmd)
end, { desc = "Search from config" })
