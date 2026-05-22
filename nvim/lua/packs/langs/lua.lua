return {
	treesitter_parsers = { "lua" },
	lsp_config = {
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
	formatters_by_ft = {
		lua = { "stylua" },
	},
	mason_install = { "lua-language-server", "stylua" },
}
