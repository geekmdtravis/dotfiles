--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Lazy asshole! Use h to move!!"<CR>', { desc = 'Disable left arrow in normal mode' })
vim.keymap.set('n', '<right>', '<cmd>echo "Lazy asshole! Use l to move!!"<CR>', { desc = 'Disable right arrow in normal mode' })
vim.keymap.set('n', '<up>', '<cmd>echo "Lazy asshole! Use k to move!!"<CR>', { desc = 'Disable up arrow in normal mode' })
vim.keymap.set('n', '<down>', '<cmd>echo "Lazy asshole! Use j to move!!"<CR>', { desc = 'Disable down arrow in normal mode' })

-- Buffer Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<S-Tab>', '<CMD>BufferLineCyclePrev<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<Tab>', '<CMD>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })

-- Scrolling and Searching
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down a page and center the cursor' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up a page and center the cursor' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Scroll down a page and center the cursor' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Scroll up a page and center the cursor' })

-- Text helpers
vim.keymap.set('n', '<Leader>pw', 'viw"_dP', { desc = '[p]aste over [w]ord under cursor' })
vim.keymap.set('n', '<Leader>pW', 'viW"_dP', { desc = '[p]aste over [W]ord under cursor' })
vim.keymap.set('v', '<Leader>ps', '"_dP', { desc = '[p]aste over [s]election under cursor' })
