return {
	treesitter = { "typescript", "javascript", "tsx" },
	lsp = {
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
	formatters = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
	},
	mason = { "vtsls", "prettier" },
}
