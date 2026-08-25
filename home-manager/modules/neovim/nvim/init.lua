require "core"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Change the color of stderr text from shell commands (:!)
vim.api.nvim_set_hl(0, "StderrMsg", { fg = "#82c8e4" })

-- require("lazy").setup("plugins")
require("lazy").setup({
  { import = "plugins.lsp" },
  { import = "plugins" },
})

vim.api.nvim_create_user_command('Tes', function()
  vim.api.nvim_create_buf(false, true)
end, {})
