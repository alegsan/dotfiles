return {
	-- add neovim ayu dark plugin
	{ "Shatur/neovim-ayu" },

	-- Configure LazyVim to load ayu colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "ayu",
		},
	},
}
