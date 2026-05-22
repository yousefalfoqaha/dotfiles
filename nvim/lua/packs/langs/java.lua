return {
	mason_install = { "jdtls", "google-java-format" },
	treesitter_parsers = { "java" },
	lsp_config = {
		jdtls = {
			settings = {
				java = {
					signatureHelp = { enabled = true },
				},
			},
		},
	},
	formatters_by_ft = {
		java = { "google-java-format" },
	},
	setup = function(mason_path)
		vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar"
	end,
}
