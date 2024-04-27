-- TODO: Remove this library when Trouble v3 was stable enough
return {
  'nvim-lua/lsp-status.nvim',
  dependencies = {
    'onsails/lspkind.nvim',
  },
  config = function()
    local lspkind = require 'lspkind'

    require('lsp-status').config {
      kind_labels = lspkind.symbol_map,
      current_function = true,
      diagnostics = false,
      status_symbol = ' ',
    }
  end,
}
