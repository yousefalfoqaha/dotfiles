vim.o.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
vim.o.swapfile = false
vim.o.wildignorecase = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.grepprg = "rg --vimgrep"
vim.o.smartindent = true
vim.o.signcolumn = "no"
vim.o.cursorline = true
vim.g.mapleader = " "
vim.o.wildmode = "longest:full,full"
vim.g.netrw_banner = 0
vim.o.completefunc = "menuone,noselect,popup"
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.wildoptions = "pum,fuzzy"

vim.g.vimtex_view_general_viewer = "evince"
vim.g.vimtex_quickfix_mode = 0

vim.g.nord_bold = false

function _G.my_find(text, _)
	local files = {}

	local git_files = vim.fn.systemlist("git ls-files --cached --others --exclude-standard 2>/dev/null")
	if vim.v.shell_error == 0 then
		files = git_files
	else
		files = vim.fn.glob("**/*", true, true)
	end

	if text == "" then
		return files
	end

	return vim.fn.matchfuzzy(files, text)
end

vim.opt.findfunc = "v:lua.my_find"
