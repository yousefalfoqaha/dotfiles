vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'

-- root namespace
vim.g.mapleader = " "

-- find namespace
vim.keymap.set('n', '<leader>ff', function() FzfLua.files() end)
vim.keymap.set('n', '<leader>fb', function() FzfLua.buffers() end)
vim.keymap.set('n', '<leader>fw', function() FzfLua.lgrep_curbuf() end)
vim.keymap.set('n', '<leader>fW', function() FzfLua.live_grep() end)
vim.keymap.set('n', '<leader>fs', function() FzfLua.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>fS', function() FzfLua.lsp_live_workspace_symbols() end)
vim.keymap.set('n', '<leader>fr', function() FzfLua.lsp_references() end)

-- lsp namespace
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format() end)

-- ergonomics
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<leader>bo', function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Delete other buffers" })

local github = function(x) return 'https://github.com/' .. x end
vim.pack.add({
	{ src = github("nvim-tree/nvim-web-devicons") },
	{ src = github("loctvl842/monokai-pro.nvim") },
	{ src = github("shaunsingh/nord.nvim") },
	{ src = github("neovim/nvim-lspconfig") },
	{ src = github("ibhagwan/fzf-lua") },
})

-- format on save
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = function()
		local _, _ = pcall(vim.lsp.buf.format, { async = false })
	end,
})

require('fzf-lua')

vim.lsp.enable({ "lua_ls", "jdtls" })

vim.cmd("colorscheme monokai-pro")
