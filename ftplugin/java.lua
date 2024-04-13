-- For other configrations you can follow the instruction of this video:
-- https://www.youtube.com/watch?v=C7juSZsM2Fg
--
-- TODO: Add some other options such as Lombok:
-- https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#configuration-verbose
--
-- TODO: Define keymaps according to the document:
-- https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#usage
--
local config = {
  cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}

require('jdtls').start_or_attach(config)
