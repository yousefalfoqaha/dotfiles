vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data') .. '/undo'

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>ff', function() FzfLua.files() end)
vim.keymap.set('n', '<leader>fb', function() FzfLua.buffers() end)
vim.keymap.set('n', '<leader>fw', function() FzfLua.lgrep_curbuf() end)
vim.keymap.set('n', '<leader>fW', function() FzfLua.live_grep() end)
vim.keymap.set('n', '<leader>fs', function() FzfLua.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>fS', function() FzfLua.lsp_live_workspace_symbols() end)
vim.keymap.set('n', '<leader>fr', function() FzfLua.lsp_references() end)

vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format() end)

vim.keymap.set('n', '<leader>bo', function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Delete other buffers" })

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.api.nvim_create_autocmd('BufWritePre', {
	group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
	pattern = '*',
	desc = 'Format on save',
	callback = function()
		local _, _ = pcall(vim.lsp.buf.format, { async = false })
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
	pattern = '*',
	desc = 'Highlight selection on yank',
	callback = function()
		vim.highlight.on_yank({ timeout = 100, visual = true })
	end,
})

local github = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = github("nvim-tree/nvim-web-devicons") },
	{ src = github("loctvl842/monokai-pro.nvim") },
	{ src = github("nordtheme/vim") },
	{ src = github("neovim/nvim-lspconfig") },
	{ src = github("mason-org/mason.nvim") },
	{ src = github("mason-org/mason-lspconfig.nvim") },
	{ src = github("ibhagwan/fzf-lua") },
})

require('fzf-lua')
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "jdtls", "lua_ls" }
})

vim.cmd("colorscheme nord")
