local github = function(x)
	return "https://github.com/" .. x
end
vim.pack.add({
	-- themes
	{ src = github("neanias/everforest-nvim") },
	{ src = github("loctvl842/monokai-pro.nvim") },
	{ src = github("luisiacc/gruvbox-baby") },
	{ src = github("EdenEast/nightfox.nvim") },
	{ src = github("kepano/flexoki-neovim") },
	{ src = github("bjarneo/ethereal.nvim") },

	-- highlighting
	{ src = github("catgoose/nvim-colorizer.lua") },
	{ src = github("nvim-treesitter/nvim-treesitter") },
	{ src = github("lewis6991/gitsigns.nvim") },
	{ src = github("MeanderingProgrammer/render-markdown.nvim") },

	-- languages
	{ src = github("neovim/nvim-lspconfig") },
	{ src = github("stevearc/conform.nvim") },
	{ src = github("mfussenegger/nvim-jdtls") },
	{ src = github("mason-org/mason.nvim") },
})

require("options")

require("render-markdown").setup()
require("gitsigns").setup()
require("colorizer").setup()

require("keymaps")
require("autocmds")

require("packs")
require("theme")
require("find")
