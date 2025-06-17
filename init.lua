-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Input
vim.opt.smartindent = true
vim.opt.encoding = 'utf-8'

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = true
vim.opt.termguicolors = true
vim.opt.showcmd = true
vim.opt.hidden = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Misc Key Maps
vim.keymap.set({'i', 'n'},  '<C-s>',       '<ESC>:w<CR>')
vim.keymap.set({'n'},       ';',           ':')

-- Buffer Key Maps
vim.keymap.set({'n'},       '<LEFT>',      ':bp<CR>')
vim.keymap.set({'n'},       '<RIGHT>',     ':bn<CR>')

-- Clipboard Key Maps
vim.keymap.set({'v'},       '<LEADER>d',   '"+d')
vim.keymap.set({'v'},       '<LEADER>y',   '"+y')
vim.keymap.set({'n'},       '<LEADER>p',   '"+p')
vim.keymap.set({'n'},       '<LEADER>P',   '"+P')

-- Toggle Key Maps
vim.keymap.set({'n'},       '<LEADER>ts',  ':set spell!<CR>:echo "spell =" &spell<CR>')
vim.keymap.set({'n'},       '<LEADER>tn',  ':set number!<CR>:set relativenumber!<CR>')

-- Movement Key Maps
vim.keymap.set({'n'},       'H',           '^')
vim.keymap.set({'n'},       'L',           '$')
vim.keymap.set({'n'},       '<C-d>',       '<C-d>zz')
vim.keymap.set({'n'},       '<C-u>',       '<C-u>zz')
