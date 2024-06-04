return {
  { -- Autoformat
    'stevearc/conform.nvim',
    -- NOTE: This change is breaking:
    --  https://github.com/stevearc/conform.nvim/commit/584adfe7c665827601f4245c0c40273e8bc9e7cb
    tag = 'v5.8.0',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'ruff_organize_imports', 'ruff_format' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },

        -- Use built-in formatter in yamlls for YAML files
        -- yaml = { 'prettier' },

        markdown = { 'prettier' },
        cpp = { 'clang_format' },
      },
      -- NOTE: This is legacy after `ruff_organize_imports` formatter
      -- formatters = {
      --   ruff_fix = {
      --     -- Always orgnize imports
      --     prepend_args = { '--extend-select', 'I' },
      --   },
      -- },
    },
  },
}
