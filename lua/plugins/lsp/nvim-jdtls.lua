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
local function get_full_cmd(cmd, fname)
  local root_dir = get_root_dir(fname)
  local project_name = get_project_name(root_dir)
  local full_cmd = vim.deepcopy(cmd)

  -- Add JDTLS's config and workspace dirs of the project
  if project_name then
    local project_jdtls_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
    vim.list_extend(full_cmd, {
      '-configuration',
      project_jdtls_dir .. '/config',
      '-data',
      project_jdtls_dir .. '/workspace',
    })
  end
  return full_cmd
end

return {
  'mfussenegger/nvim-jdtls',
  ft = java_filetypes,
  opts = {
    cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/jdtls' },
    settings = {
      java = {
        inlayHints = {
          parameterNames = {
            enabled = 'all',
          },
        },
      },
    },
  },
  config = function(_, opts)
    local function attach_jdtls()
      local fname = vim.api.nvim_buf_get_name(0)

      -- Existing server will be reused if the root_dir matches
      -- No need to `require("jdtls.setup").add_commands()`, start automatically adds commands
      require('jdtls').start_or_attach {
        cmd = get_full_cmd(opts.cmd, fname),
        root_dir = get_root_dir(fname),
        capabilities = {
          unpack(require('cmp_nvim_lsp').default_capabilities()), -- CMP capabilities
        },
        settings = opts.settings,
      }
    end

    -- Attach JDTL to the buffer
    attach_jdtls()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = java_filetypes,
      callback = attach_jdtls,
    })

    -- Enable inlay hint
    vim.lsp.inlay_hint.enable(true)

    -- Add mappings
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil or client.name ~= 'jdtls' then
          return
        end

        local which_key = require 'which-key'

        -- Normal mode mappings
        which_key.register({
          ['<leader>cx'] = { name = '+E[x]tract' },
          ['<leader>cxv'] = { require('jdtls').extract_variable_all, 'Extract [V]ariable' },
          ['<leader>cxc'] = { require('jdtls').extract_constant, 'Extract [C]onstant' },
          ['gs'] = { require('jdtls').super_implementation, 'LSP: [G]oto [S]uper' },
          ['gS'] = { require('jdtls.tests').goto_subjects, 'LSP: [G]oto [S]ubjects' },
          ['<leader>co'] = { require('jdtls').organize_imports, '[O]rganize Imports' },
        }, { mode = 'n', buffer = args.buf })

        -- Visual mode mappings
        which_key.register({
          ['<leader>c'] = { name = '+[C]ode' },
          ['<leader>cx'] = { name = '+E[x]tract' },
          ['<leader>cxm'] = {
            [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
            'Extract [M]ethod',
          },
          ['<leader>cxv'] = {
            [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
            'Extract [V]ariable',
          },
          ['<leader>cxc'] = {
            [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
            'Extract [C]onstant',
          },
        }, { mode = 'v', buffer = args.buf })
      end,
    })
  end,
}
