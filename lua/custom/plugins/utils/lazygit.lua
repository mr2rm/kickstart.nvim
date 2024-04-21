return {
  { -- Lazygit
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
      {
        '<leader>slg',
        function()
          require('telescope').extensions.lazygit.lazygit()
        end,
        desc = '[S]earch [L]azy[G]it Repository',
      },
    },
    config = function()
      require('telescope').load_extension 'lazygit'

      -- That makes sure that any opened buffer which is contained in a git
      -- repo will be tracked.
      vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'Load repository path',
        pattern = '*',
        callback = function()
          require('lazygit.utils').project_root_dir()
        end,
      })
    end,
  },
}
