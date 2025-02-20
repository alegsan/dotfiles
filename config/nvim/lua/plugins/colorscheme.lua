return {
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false, -- Disable the mirage variant to use ayu-dark
				overrides = function()
					local colors = require("ayu.colors")
					return {
						LineNr = { fg = colors.comment },
						CursorLineNr = { fg = "#FFD700", bold = true },
						NonText = { fg = colors.comment },
						WinSeparator = { fg = colors.comment },
						VertSplit = { fg = colors.comment },
						SnacksIndent = { fg = colors.guide_normal },
						Whitespace = { fg = colors.guide_normal },
					}
				end,
			})
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "ayu-dark",
		},
	},
}
