-- TODO: There are some overlapping keymaps on health-checking
return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      spec = {
        { '<leader>a', group = '[A]I' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>n', group = '[N]otification' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = 'File [T]ree' },
        { '<leader>v', group = '[V]env' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>x', group = 'Trouble' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
