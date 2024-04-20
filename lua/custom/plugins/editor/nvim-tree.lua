return { -- File Tree
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>tt',
      '<cmd>NvimTreeToggle<cr>',
      desc = 'File [T]ree: [T]oggle',
    },
    {
      '<leader>tf',
      '<cmd>NvimTreeFindFile<cr>',
      desc = 'File [T]ree: Find Current [F]ile',
    },
    {
      '<leader>tb',
      '<cmd>NvimTreeCollapseKeepBuffers<cr>',
      desc = 'File [T]ree: Show [B]uffers',
    },
  },
  config = function()
    require('nvim-tree').setup {
      hijack_cursor = true,
      diagnostics = {
        enable = true,
      },
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        signcolumn = 'auto',
        preserve_window_proportions = true,
        adaptive_size = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = 'after',
          diagnostics_placement = 'after',
        },
      },
      filters = {
        dotfiles = true,
      },
      tab = {
        sync = {
          close = true,
        },
      },
    }
  end,
}
