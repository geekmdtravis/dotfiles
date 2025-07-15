require 'cfg.settings'
require 'cfg.autocommands'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  'hrsh7th/nvim-cmp',
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  -- require 'cfg.plugins.copilot-lua',
  require 'cfg.plugins.bufferline',
  require 'cfg.plugins.debug',
  require 'cfg.plugins.fterm',
  require 'cfg.plugins.gitsigns',
  require 'cfg.plugins.langutils.blink-cmp',
  require 'cfg.plugins.langutils.conform',
  require 'cfg.plugins.langutils.todo-comments',
  require 'cfg.plugins.lsp.lazydev',
  require 'cfg.plugins.lsp.nvim-lspconfig',
  require 'cfg.plugins.motionutils.mini',
  require 'cfg.plugins.neo-tree',
  require 'cfg.plugins.no-neck-pain',
  -- require 'cfg.plugins.obsidian',
  require 'cfg.plugins.persistence',
  require 'cfg.plugins.qmk',
  require 'cfg.plugins.render-markdown',
  require 'cfg.plugins.supermaven',
  require 'cfg.plugins.telescope',
  require 'cfg.plugins.treesitter',
  require 'cfg.plugins.trouble',
  require 'cfg.plugins.which-key',
  require 'cfg.themes.tokyonight',
}, {
  ui = require 'cfg.ui',
})
require 'cfg.keymaps'
