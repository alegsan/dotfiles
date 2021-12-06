local M = {}

function M.setup()
  local lsp_installer = require("nvim-lsp-installer")
  local lsputils = require("config.lsp.utils")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
  lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(vim.tbl_deep_extend("force", {
      on_attach = lsputils.lsp_attach,
      on_exit = lsputils.lsp_exit,
      on_init = lsputils.lsp_init,
      capabilities = lsputils.get_capabilities(),
      flags = { debounce_text_changes = 150 },
    }, {}))
  end)
end

return M
