return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      'zbirenbaum/copilot.lua', -- or github/copilot.vim
      'nvim-lua/plenary.nvim', -- for curl, log wrapper
      'nvim-telescope/telescope.nvim', -- show actions
    },
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = 'gpt-4o',
        auto_insert_mode = true,
        show_help = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
        chat_autocomplete = true,
        selection = function(source)
          local select = require 'CopilotChat.select'
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle Chat',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear Chat',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end,
        desc = '[Q]uick Chat',
        mode = { 'n', 'v' },
      },
      { -- Show help actions with telescope
        '<leader>ad',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = '[D]iagnostic Help',
        mode = { 'n', 'v' },
      },
      { -- Show prompts actions with telescope
        '<leader>ap',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = '[P]rompt Actions',
        mode = { 'n', 'v' },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
