vim.o.termguicolors = true
vim.o.shiftwidth = 2
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'
vim.o.undofile = true
vim.o.swapfile = false
vim.o.undodir = vim.fn.stdpath('data') .. '/undo'
vim.o.wildignorecase = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.grepprg = "rg --vimgrep"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.definition() end)

vim.keymap.set('n', '<leader>g', ':copen | :silent :gr! ')

vim.keymap.set('n', '<leader>bo', function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Delete other buffers" })

vim.keymap.set('n', '<leader>bd', function() vim.cmd("bd") end)

vim.keymap.set('n', '<leader>ff', function() FzfLua.files() end)
vim.keymap.set('n', '<leader>fb', function() FzfLua.buffers() end)
vim.keymap.set('n', '<leader>fw', function() FzfLua.lgrep_curbuf() end)
vim.keymap.set('n', '<leader>fW', function() FzfLua.live_grep() end)
vim.keymap.set('n', '<leader>fs', function() FzfLua.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>fS', function() FzfLua.lsp_live_workspace_symbols() end)
vim.keymap.set('n', '<leader>fr', function() FzfLua.lsp_references() end)

vim.keymap.set('n', '<leader>e', function() vim.cmd("Oil") end)
vim.keymap.set('n', '<leader>w', function() vim.cmd("w") end)
vim.keymap.set('n', '<leader>q', function() vim.cmd("q") end)

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
	desc = 'Highlight selection on yank',
	callback = function()
		vim.highlight.on_yank({ timeout = 100, visual = true })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		local _ = pcall(vim.treesitter.start)
	end,
})

local github = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = github("stevearc/oil.nvim") },
	{ src = github("nvim-tree/nvim-web-devicons") },
	{ src = github("loctvl842/monokai-pro.nvim") },
	{ src = github("stevearc/conform.nvim") },
	{ src = github("nordtheme/vim") },
	{ src = github("kepano/flexoki-neovim") },
	{ src = github("norcalli/nvim-colorizer.lua") },
	{ src = github("nvim-treesitter/nvim-treesitter") },
	{ src = github("neovim/nvim-lspconfig") },
	{ src = github("mason-org/mason.nvim") },
	{ src = github("mason-org/mason-lspconfig.nvim") },
	{ src = github("ibhagwan/fzf-lua") },
})

require('fzf-lua')
require('oil').setup()
require('conform').setup({
	formatters_by_ft = {
		java = { 'google-java-format' }
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "jdtls", "lua_ls", "ts_ls" }
})
require('nvim-treesitter').install({ 'java', 'typescript', 'html', 'css' })
require('colorizer').setup()
require('theme')
require('find')
