return {
	treesitter_parsers = { "html", "css" },
	formatters_by_ft = {
		html = { "prettier" },
		css = { "prettier" },
	},
	mason_install = { "prettier", "html-lsp" },
}
