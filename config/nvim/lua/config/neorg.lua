local M = {}

function M.setup()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/workspace/dev/notes",
          },
        },
      },
    },
  }
end

return M
