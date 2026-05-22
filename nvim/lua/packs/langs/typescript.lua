return {
	treesitter_parsers = { "typescript", "javascript", "tsx" },
	lsp_config = {
		vtsls = {
			settings = {
				typescript = {
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
				javascript = {
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
			},
		},
	},
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
	},
	mason_install = { "vtsls", "prettier" },
}
