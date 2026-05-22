return {
	treesitter_parsers = { "markdown" },
	lsp_config = { "marksman" },
	formatters_by_ft = {
		markdown = { "prettier" },
	},
	mason_install = { "marksman", "prettier" },
}
