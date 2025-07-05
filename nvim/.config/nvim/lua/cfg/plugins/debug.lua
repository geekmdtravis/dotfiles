local function get_python_path()
  local venv = os.getenv 'VIRTUAL_ENV'
  if venv and venv ~= '' then
    return venv .. '/bin/python'
  end
  local conda_prefix = os.getenv 'CONDA_PREFIX'
  if conda_prefix and conda_prefix ~= '' then
    return conda_prefix .. '/bin/python'
  end
  return vim.fn.exepath 'python3' or vim.fn.exepath 'python'
end

local dap_keymaps = {
  {
    '<Leader>dc',
    function()
      require('dap').continue()
    end,
    desc = '[D]ebug: [C]ontinue/Start',
  },
  {
    '<Leader>di',
    function()
      require('dap').step_into()
    end,
    desc = '[D]ebug: [S]tep Into',
  },
  {
    '<Leader>ds',
    function()
      require('dap').step_over()
    end,
    desc = '[D]ebug: [S]tep Over',
  },
  {
    '<Leader>do',
    function()
      require('dap').step_out()
    end,
    desc = '[D]ebug: Step [O]ut',
  },
  {
    '<Leader>db',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = '[D]ebug: Toggle [B]reakpoint',
  },
  {
    '<Leader>dB',
    function()
      require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end,
    desc = '[D]ebug: Set [B]reakpoint Condition',
  },
  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  {
    '<Leader>dS',
    function()
      require('dapui').toggle()
    end,
    desc = '[D]ebug: See last [S]ession result.',
  },
}

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Creates a beautiful debugger UI
    'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui

    -- Add the things you want to ensure are installed
    -- to the ensure_installed list in nvim-dap located
    -- in the nvim-lspconfig.lua file.
  },
  keys = dap_keymaps,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Add Python debug adapters and configurations
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        python = get_python_path,
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      },
      {
        type = 'python',
        request = 'attach',
        name = 'Attach to process',
        processId = '${command:pickProcess}',
        python = get_python_path,
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      },
    }

    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }

    -- Add JS/TS/React debug adapters and configurations
    for _, adapterType in ipairs { 'node', 'chrome', 'msedge' } do
      local pwaType = 'pwa-' .. adapterType

      dap.adapters[pwaType] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      -- this allow us to handle launch.json configurations
      -- which specify type as "node" or "chrome" or "msedge"
      dap.adapters[adapterType] = function(cb, config)
        local nativeAdapter = dap.adapters[pwaType]

        config.type = pwaType

        if type(nativeAdapter) == 'function' then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local enter_launch_url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:' }, function(url)
          if url == nil or url == '' then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end

    for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file using Node.js (nvim-dap)',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process using Node.js (nvim-dap)',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        -- requires ts-node to be installed globally or locally
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file using Node.js with ts-node/register (nvim-dap)',
          program = '${file}',
          cwd = '${workspaceFolder}',
          runtimeArgs = { '-r', 'ts-node/register' },
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (nvim-dap)',
          url = enter_launch_url,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-msedge',
          request = 'launch',
          name = 'Launch Edge (nvim-dap)',
          url = enter_launch_url,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }
    end

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
