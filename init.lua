vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = 'rounded'

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>o', vim.cmd.so)
vim.keymap.set('n', '<leader>f', vim.cmd.pick.files)
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.keymap.set({'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/nvim-mini/mini.pick"},
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

require "mini.pick".setup()

require("rose-pine").setup({
  styles = {
    bold = false,
    italic = true,
    transparency = true,
  },
})

vim.lsp.enable({"lua_ls", "jdtls"})
vim.cmd("colorscheme rose-pine")
