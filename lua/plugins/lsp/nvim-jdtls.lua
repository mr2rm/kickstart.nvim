local java_filetypes = { 'java' }

-- Find the root dir of the project for a given file
local function get_root_dir(fname)
  local jdtls = require 'lspconfig.server_configurations.jdtls'
  return jdtls.default_config.root_dir(fname)
end

-- Find the project name for a given root dir
local function get_project_name(root_dir)
  return root_dir and vim.fs.basename(root_dir)
end

-- Get the full command to start JDTLS
local function get_full_cmd(fname, default)
  local root_dir = get_root_dir(fname)
  local project_name = get_project_name(root_dir)
  local cmd = vim.deepcopy(default)

  -- Add JDTLS's config and workspace dirs of the project
  if project_name then
    local project_jdtls_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
    vim.list_extend(cmd, {
      '-configuration',
      project_jdtls_dir .. '/config',
      '-data',
      project_jdtls_dir .. '/workspace',
    })
  end
  return cmd
end

return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    -- Show LSP status on statusline
    -- TODO: Replace it with newer version of Trouble
    'nvim-lua/lsp-status.nvim',
  },
  ft = java_filetypes,
  opts = {
    cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/jdtls' },
    jdtls = {},
  },
  config = function(_, opts)
    local lsp_status = require 'lsp-status'

    local function attach_jdtls()
      local fname = vim.api.nvim_buf_get_name(0)

      -- Configuration can be augmented and overridden by `opts.jdtls`
      local default_config = {
        cmd = get_full_cmd(fname, opts.cmd),
        root_dir = get_root_dir(fname),
        on_attach = lsp_status.on_attach,
        capabilities = lsp_status.capabilities,
      }
      local jdtls_config = opts.jdtls or {}
      local config = vim.tbl_deep_extend('force', default_config, jdtls_config)

      -- Existing server will be reused if the root_dir matches
      -- No need to `require("jdtls.setup").add_commands()`, start automatically adds commands
      require('jdtls').start_or_attach(config)
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = java_filetypes,
      callback = attach_jdtls,
    })
    attach_jdtls()
  end,
}
