return {
  -- add gruvbox
  { "Shatur/neovim-ayu" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
