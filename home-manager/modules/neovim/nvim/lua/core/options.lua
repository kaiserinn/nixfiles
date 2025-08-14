vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.laststatus = 3 -- global statusline
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

opt.cursorline = true
opt.pumheight = 10 -- Maximum number of items to show in the popup menu
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 2

opt.fillchars = { eob = " " }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = false

opt.scrolloff = 5
opt.sidescrolloff = 5

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 200
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"

opt.breakindent = true

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect,preview"

-- change insert cursor
opt.guicursor = "n-v-c-sm-i:block,ci-ve:ver25-Cursor,r-cr-o:hor20"

-- borders for lsp hover, diagnostics, etc.
vim.opt.winborder = "none"
