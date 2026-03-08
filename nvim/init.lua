vim.o.termguicolors = true
vim.o.shiftwidth = 2
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.swapfile = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
vim.o.wildignorecase = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.grepprg = "rg --vimgrep"
vim.o.smartindent = true
vim.o.signcolumn = "yes"
vim.opt.statuscolumn = "%s%3l   "
vim.o.cursorline = true
vim.g.mapleader = " "
vim.o.wildmode = "noselect:lastused:full"
vim.g.netrw_banner = 0
vim.o.completeopt = "menuone,noselect,popup"

vim.keymap.set("n", "<leader>o", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end)

vim.keymap.set("n", "<leader>t", ":Theme ")

vim.keymap.set("n", "<leader>g", ":copen | :silent :gr! ")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 100, visual = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local _ = pcall(vim.treesitter.start)
	end,
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		if not client then
			return
		end

		vim.lsp.completion.enable(true, client.id, bufnr, {
			-- autotrigger = true,
			convert = function(item)
				return { abbr = item.label:gsub("%b()", "") }
			end,
		})
		-- vim.api.nvim_create_autocmd("InsertCharPre", {
		-- 	buffer = bufnr,
		-- 	callback = vim.lsp.completion.get,
		-- })
	end,
})

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

vim.lsp.enable({ "lua_ls", "vtsls", "jdtls", "marksman", "clangd" })

local mason_path = vim.fn.stdpath("data") .. "/mason"

vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar"

vim.lsp.config("jdtls", {
	settings = {
		java = {
			signatureHelp = { enabled = true },
		},
	},
})

require("mason").setup()
require("render-markdown").setup({})
require("gitsigns").setup()
require("conform").setup({
	formatters_by_ft = {
		java = { "google-java-format" },
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		markdown = { "prettier", "marksman" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require("nvim-treesitter").install({
	"java",
	"typescript",
	"html",
	"css",
	"python",
	"markdown",
	"json",
	"yaml",
	"toml",
})
require("colorizer").setup()
require("theme")
require("find")
