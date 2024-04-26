-- TODO: Activate venv by moving to a directory
-- If .envrc exists, only need to copy shell $PATH to current $PATH
-- Otherwise we need to check if there is a valid venv, then:
--    1. Active the venv
--    2. Update current $PATH

return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    opts = {
      -- Your options go here
      -- name = "venv",
      auto_refresh = true,
    },
    -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    event = 'VeryLazy',
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = '[S]elect' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = '[C]urrent' },
    },
    -- config = function()
    --   vim.api.nvim_create_autocmd('VimEnter', {
    --     desc = 'Auto select virtualenv Nvim open',
    --     pattern = '*',
    --     callback = function()
    --       local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
    --       if venv ~= '' then
    --         require('venv-selector').retrieve_from_cache()
    --       end
    --     end,
    --     once = true,
    --   })
    --   vim.api.nvim_create_autocmd('DirChanged', {
    --     desc = 'Change venv if needed',
    --     pattern = '*',
    --     callback = function()
    --       print(vim.fn.getcwd())
    --       -- vim.fn.system { 'direnv', 'reload' }
    --       -- vim.fn.system { 'poetry', 'shell' }
    --       vim.fn.system { 'poetry', '-C', vim.fn.getcwd(), 'shell' }
    --     end,
    --   })
    -- end,
  },
}
