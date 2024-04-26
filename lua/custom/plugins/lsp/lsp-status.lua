-- TODO: Remove this library when Trouble v3 was stable
-- Disabling diagnostics and changing icons / lables don't work
return {
  'nvim-lua/lsp-status.nvim',
  configs = {
    current_function = true,
    indicator_errors = ' ',
    indicator_warnings = ' ',
    indicator_info = ' ',
    indiciator_hint = ' ',
  },
}
