local map = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, {
      noremap = true,
      silent = true,
      desc = "Core: " .. desc,
  })
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- nmap("n", "<C-h>", "<C-w>h", "Move to the window on the left.")
-- nmap("n", "<C-j>", "<C-w>j", "Move to the window on the right.")
-- nmap("n", "<C-k>", "<C-w>k", "Move to the window on the bottom.")
-- nmap("n", "<C-l>", "<C-w>l", "Move to the window on the top.")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", "Resize current window's height by 2 lines up.")
map("n", "<C-Down>", ":resize +2<CR>", "Resize current window's height by 2 lines down.")
map("n", "<C-Left>", ":vertical resize +2<CR>", "Resize current window's width by 2 lines left.")
map("n", "<C-Right>", ":vertical resize -2<CR>", "Resize current window's width by 2 lines right.")

-- Navigate buffers
map("n", "<S-l>", "<CMD>bnext<CR>", "Switch to the next buffer.")
map("n", "<S-h>", "<CMD>bprevious<CR>", "Switch to the previous buffer.")
map("n", "<leader>x", "<CMD>bdelete<CR>", "Close current buffer")
map("n", "<leader>w", "<CMD>tabclose<CR>", "Close current tab")

-- Move text up and down
map("n", "<A-J>", ":m .+1<CR>==", "Move line down.")
map("n", "<A-K>", ":m .-2<CR>==", "Move line up.")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- LSPs
map("n", "<S-k>", function() vim.lsp.buf.hover({ border = "rounded" }) end, "")
map('n', '<space>f', vim.diagnostic.open_float, "Open diagnostic.")
-- nmap('n', '[d', vim.diagnostic.goto_prev, "Go to previous diagnostic")
-- nmap('n', ']d', vim.diagnostic.goto_next, "Go to next diagnostic")
-- nmap('n', '<space>q', vim.diagnostic.setloclist)
map('i', '<C-m>', vim.lsp.buf.signature_help, "Open signature_help")

-- Misc
map('n', '<Esc>', ':noh <CR>', 'Clear highlights')
map('n', '<C-j>', '5j', 'Move 5 lines down')
map('n', '<C-k>', '5k', 'Move 5 lines up')

map('n', '<leader>z', ':q<CR>', 'Close current window')
map('n', '<leader>sv', ':vsplit<CR>', 'Split window vertically')
map('n', '<leader>sh', ':split<CR>', 'Split window horizontally')

-- Insert --
-- Move around in insert mode
map("i", "<C-k>", "<Up>", "Move up")
map("i", "<C-l>", "<Right>", "Move right")
map("i", "<C-j>", "<Down>", "Move down")
map("i", "<C-h>", "<Left>", "Move left")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv^", "Shift the selected text left, then reselect the visual block.")
map("v", ">", ">gv^", "Shift the selected text right, then reselect the visual block.")

map("v", '<C-j>', '5j', 'Move 5 lines down')
map("v", '<C-k>', '5k', 'Move 5 lines up')

-- Move text up and down
map("v", "<A-J>", ":m '>+1<CR>gv=gv", "Move line down.")
map("v", "<A-K>", ":m '<-2<CR>gv=gv", "Move line up.")
map("v", "p", '"_dP', "Paste the yanked text, replacing the selected text.")

-- Visual Block --
-- Move text up and down
map("x", "<A-J>", ":m '>+1<CR>gv=gv", "Move line down.")
map("x", "<A-K>", ":m '<-2<CR>gv=gv", "Move line up.")

-- Delete & Yank extras
map({"n", "v"}, "d", "\"_d", "Delete without yanking")
map("v", "p", "\"_dP", "Replace-paste without yanking")

-- Save File
map({"n", "s"}, "<C-s>", ":w<CR>", "Save current file")

-- Select All
map("n", "<C-A>", "ggVG", "Select all")
