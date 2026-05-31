return {
	mason_install = { "gopls", "gofumpt" },
	treesitter_parsers = { "go" },
	lsp_configs = { "gopls" },
	formatters_by_ft = {
		go = { "gofumpt" },
	},
}
