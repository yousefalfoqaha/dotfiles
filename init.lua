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
vim.keymap.set('n', '<leader>fq', function() FzfLua.quickfix() end)
vim.keymap.set('n', '<leader>fl', function() FzfLua.loclist() end)
vim.keymap.set('n', '<leader>fs', function() FzfLua.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>fS', function() FzfLua.lsp_live_workspace_symbols() end)
vim.keymap.set('n', '<leader>fr', function() FzfLua.lsp_references() end)

-- lsp namespace
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format() end)

vim.pack.add({
	{ src = "https://github.com/loctvl842/monokai-pro.nvim" },
	{ src = "https://github.com/shaunsingh/nord.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

require("fzf-lua")

vim.lsp.enable({ "lua_ls", "jdtls" })

vim.cmd("colorscheme monokai-pro")
