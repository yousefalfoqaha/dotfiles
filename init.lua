vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
vim.keymap.set('n', '<leader>f', ':find **/')
vim.keymap.set('n', '<leader>cf', function()
	vim.lsp.buf.format({ async = false })
end)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Goo to definition" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Goo to references" })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
	{ src = "https://github.com/shaunsingh/nord.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable({ "lua_ls", "jdtls" })
vim.cmd("colorscheme nord")
