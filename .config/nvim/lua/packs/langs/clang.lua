return {
	treesitter_parsers = { "c", "cpp" },
	lsp_configs = { "clangd" },
	mason_install = { "clangd", "clang-format" },
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
}
