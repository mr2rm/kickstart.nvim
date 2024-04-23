return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      --- @param trunc_width number? trunctates component when screen width is less then trunc_width
      --- @param trunc_len number truncates component to trunc_len number of chars
      --- @param hide_width number? hides component when window width is smaller then hide_width
      --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
      --- return function that can format the component accordingly
      local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
        return function(str)
          local win_width = vim.fn.winwidth(0)
          -- Hide
          if hide_width and win_width < hide_width then
            return ''
          end
          -- Truncate
          if trunc_len and #str > trunc_len then
            if trunc_width == nil or win_width < trunc_width then
              return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
            end
          end
          -- No change
          return str
        end
      end

      return {
        options = { theme = 'tokyonight' },
        extensions = { 'nvim-tree', 'lazy' },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', fmt = trunc(nil, 25, nil, false) },
          },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = ' ',
                warn = ' ',
                info = ' ',
                hint = ' ',
              },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename' },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function()
                return require('noice').api.status.command.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.command.has()
              end,
              color = { fg = '#ff9e64' },
            },
            -- stylua: ignore
            {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = { fg = '#ff9e64' },
            },
            -- stylua: ignore
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates,
            },
            {
              'diff',
              symbols = {
                added = ' ',
                modified = ' ',
                removed = ' ',
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return ' ' .. os.date '%R'
            end,
          },
        },
        tabline = {
          lualine_a = { 'tabs' },
          lualine_z = { 'buffers' },
        },
      }
    end,
  },
}
