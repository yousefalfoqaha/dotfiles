return {
	treesitter_parsers = { "c", "cpp" },
	lsp_config = { "clangd" },
	mason_install = { "clangd", "clang-format" },
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
}
