local M = {}

function M.setup()
  local vim = vim
  local lspconfig = require("lspconfig")
  local lsputils = require("config.lsp.utils")

  require("mason").setup()
  require("mason-lspconfig").setup()

  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
      on_attach = lsputils.lsp_attach,
      on_exit = lsputils.lsp_exit,
      on_init = lsputils.lsp_init,
      capabilities = lsputils.get_capabilities(),
      flags = { debounce_text_changes = 150 },
  })

  require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
      end,
      -- -- Next, you can provide a dedicated handler for specific servers.
      -- -- For example, a handler override for the `rust_analyzer`:
      -- ["rust_analyzer"] = function ()
      --     require("rust-tools").setup {}
      -- end
  }

  -- local lsp_installer = require("mason-lspconfig")

-- -- Register a handler that will be called for all installed servers.
-- -- Alternatively, you may also register handlers on specific server instances instead (see example below).
  -- lsp_installer.on_server_ready(function(server)
  --   local opts = {}

  --   -- This setup() function is exactly the same as lspconfig's setup function.
  --   -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  --   server:setup(vim.tbl_deep_extend("force", {
  --     on_attach = lsputils.lsp_attach,
  --     on_exit = lsputils.lsp_exit,
  --     on_init = lsputils.lsp_init,
  --     capabilities = lsputils.get_capabilities(),
  --     flags = { debounce_text_changes = 150 },
  --   }, {}))
  -- end)
end

return M
