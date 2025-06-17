-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Setup Plugins
require("lazy").setup({
  { 'tpope/vim-fugitive', lazy = true },
  { 'tpope/vim-sleuth', lazy = true },
  { 'tpope/vim-surround', lazy = true },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
})

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

-- Telescope Key Maps
local telescope = require('telescope.builtin')
vim.keymap.set({'n'},  '<LEADER>ff',  telescope.find_files)
vim.keymap.set({'n'},  '<LEADER>fg',  telescope.live_grep)
vim.keymap.set({'n'},  '<LEADER>fb',  telescope.buffers)
vim.keymap.set({'n'},  '<LEADER>fh',  telescope.help_tags)
vim.keymap.set({'n'},  '<LEADER>fm',  telescope.marks)
vim.keymap.set({'n'},  '<LEADER>fq',  telescope.quickfix)
vim.keymap.set({'n'},  '<LEADER>fk',  telescope.keymaps)
vim.keymap.set({'n'},  '<LEADER>/',   telescope.live_grep)
vim.keymap.set({'n'},  '<LEADER>.',   telescope.git_files)
