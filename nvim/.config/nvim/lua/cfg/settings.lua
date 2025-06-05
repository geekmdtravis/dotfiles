vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.conceallevel = 1 -- Set for obsidian.nvim
vim.o.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300
-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
-- Show which line your cursor is on
vim.o.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
-- Ask to confirm when closing a modified buffer instead of just quitting, potentially failing and losing changes.
vim.o.confirm = true
-- Convert tabs to spaces
vim.o.expandtab = true
-- Number of spaces for auto-indent
vim.o.shiftwidth = 2
-- Number of spaces a tab counts for
vim.o.tabstop = 2
-- Number of spaces a tab counts for while editing
vim.o.softtabstop = 2
