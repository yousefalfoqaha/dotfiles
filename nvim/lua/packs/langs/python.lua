return {
	mason_install = { "pyright", "ruff" },
	treesitter_parsers = { "python" },
	lsp_configs = { "pyright" },
	formatters_by_ft = {
		python = { "ruff_format", "ruff_organize_imports" },
	},
}
