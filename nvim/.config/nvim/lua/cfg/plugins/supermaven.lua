return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<S-Esc>',
        accept_word = '<S-Tab>',
      },
      -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
      color = {
        suggestion_color = '#D2042D',
        cterm = 244,
      },
      log_level = 'info', -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return false
      end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    }
  end,
  vim.keymap.set('i', '<A-l>', function()
    require('supermaven-nvim.api').toggle()
    local is_running = require('supermaven-nvim.api').is_running()
    if is_running then
      vim.notify 'Supermaven is running'
    else
      vim.notify 'Supermaven is not running'
    end
  end, { noremap = true, silent = true }),
}
