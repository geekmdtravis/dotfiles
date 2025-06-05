return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',

  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup {
      options = {
        separator_style = 'slope',
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
      },
    }
  end,
}
