return {
  'folke/persistence.nvim',
  event = 'VimEnter',
  -- event = 'BufReadPre',
  config = function()
    require('persistence').setup {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      need = 1,
      branch = true,
    }
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        -- Close neo-tree before saving the session if it is installed.
        local lazy_ok, lazy = pcall(require, 'lazy')
        if lazy_ok and lazy.plugins()['neo-tree.nvim'] then
          vim.defer_fn(function()
            vim.cmd 'Neotree close'
          end, 50)
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePost',
      callback = function()
        vim.notify('Session saved successfully!', vim.log.levels.INFO)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceLoadPre',
      callback = function()
        -- Open neo-tree after with slight delay after load if it is installed.
        local lazy_ok, lazy = pcall(require, 'lazy')
        if lazy_ok and lazy.plugins()['neo-tree.nvim'] then
          vim.defer_fn(function()
            vim.cmd 'Neotree show'
          end, 50)
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceLoadPost',
      callback = function()
        -- Remove any dangling empty buffers upon load.
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          print('Buffer name: ', buf_name)
          if string.find(buf_name, 'neo-tree filesystem', 1, true) then
            vim.api.nvim_buf_delete(buf, { force = true })
            print('Deleted neo-tree buffer:', buf)
          end
          if buf_name == '' then
            vim.api.nvim_buf_delete(buf, { force = true })
            print('Deleted unnamed buffer: ', buf)
          end
        end
        -- Check if lazy.nvim has neo-tree installed and loaded
        local lazy_ok, lazy = pcall(require, 'lazy')
        if lazy_ok and lazy.plugins()['neo-tree.nvim'] then
          vim.defer_fn(function()
            vim.cmd 'Neotree show'
          end, 50)
        end
      end,
    })

    -- Define key mappings
    vim.keymap.set('n', '<leader>ps', function()
      require('persistence').load()
    end, { desc = 'Load session for current directory' })

    vim.keymap.set('n', '<leader>pS', function()
      require('persistence').select()
    end, { desc = 'Select session to load' })

    vim.keymap.set('n', '<leader>pl', function()
      require('persistence').load { last = true }
    end, { desc = 'Load last session' })

    vim.keymap.set('n', '<leader>pd', function()
      require('persistence').stop()
    end, { desc = 'Stop Persistence (session will not be saved on exit)' })
  end,
}
