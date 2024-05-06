return {
  { -- Neogit
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      -- TODO: Configure diffview

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      -- 'ibhagwan/fzf-lua', -- optional
    },
    config = true,
    opts = {
      graph_style = 'unicode',
      signs = {
        section = { '', '' },
        item = { '', '' },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
    keys = {
      { '<leader>gn', '<cmd>Neogit<CR>', desc = '[N]eogit' },
    },
  },
}
