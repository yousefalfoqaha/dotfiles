vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'

-- leader
vim.g.mapleader = " "

-- fuzzy find
vim.keymap.set('n', '<leader>ff', function() FzfLua.files() end)
vim.keymap.set('n', '<leader>fb', function() FzfLua.buffers() end)
vim.keymap.set('n', '<leader>fw', function() FzfLua.live_grep() end)
vim.keymap.set('n', '<leader>fc', function() FzfLua.lgrep_curbuf() end)
vim.keymap.set('n', '<leader>fq', function() FzfLua.quickfix() end)
vim.keymap.set('n', '<leader>fl', function() FzfLua.loclist() end)
vim.keymap.set('n', '<leader>fs', function() FzfLua.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>fr', function() FzfLua.lsp_references() end)

-- code
vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format() end)

vim.pack.add({
	{ src = "https://github.com/shaunsingh/nord.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client.id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

require("fzf-lua")
-- require("nvim-treesitter.config").setup({
-- 	ensure_installed = { "java" },
-- 	highlight = { enable = true },
-- 	install_dir = vim.fin.stdpath('data') .. '/site'
-- })

vim.lsp.enable({ "lua_ls", "jdtls" })

vim.cmd("colorscheme nord")
