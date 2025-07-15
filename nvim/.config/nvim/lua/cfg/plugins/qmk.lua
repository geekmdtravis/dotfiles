return {
  'codethread/qmk.nvim',
  config = function()
    ---@type qmk.UserConfig
    local conf = {
      name = 'LAYOUT',
      layout = {
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x x x x x x x x x',
        '_ _ _ _ x x x x x x _ _ _ _',
      },
    }
    require('qmk').setup(conf)
  end,
}
