return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          ignored = true,
          hidden = false,
        },
        grep = {
          ignored = true,
          hidden = true,
        },
        files = {
          ignored = true,
          hidden = true,
        },
      },
    },
  },
}
