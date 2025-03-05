return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"clang-format",
				"clangd",
				"lua-language-server",
				"luacheck",
				"prettier",
				"pyright",
				"ruff",
				"shellcheck",
				"shfmt",
				"stylua",
				"yaml-language-server",
			},
		},
	},
}
