return {
	treesitter = { "lua" },
	lsp = {
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		},
	},
	formatters = {
		lua = { "stylua" },
	},
	mason = { "lua-language-server", "stylua" },
}
