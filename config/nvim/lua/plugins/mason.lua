return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"pyright",
				"bash-language-server",
				"lua-language-server",
				"ruff",
				"yaml-language-server",
				"clangd",
				"shellcheck",
			},
		},
	},
}
