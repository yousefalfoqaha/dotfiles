return {
	mason = { "jdtls", "google-java-format" },
	treesitter = { "java" },
	lsp = {
		jdtls = {
			settings = {
				java = {
					signatureHelp = { enabled = true },
				},
			},
		},
	},
	formatters = {
		java = { "google-java-format" },
	},
	setup = function(mason_path)
		vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar"
	end,
}
