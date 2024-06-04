return {
  { -- Neogit
    'NeogitOrg/neogit',
    -- NOTE: This change is breaking:
    --  https://github.com/NeogitOrg/neogit/commit/f0cd768765e56259180eb68bc95488af933a4908
    tag = 'v1.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      -- TODO: Configure diffview

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      -- 'ibhagwan/fzf-lua', -- optional
    },
    cmd = 'Neogit',
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
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neo[G]it' },
    },
  },
}
