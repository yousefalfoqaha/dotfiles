vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "no"
vim.opt.guicursor = "n-v-c-i:block"
vim.o.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.grepprg = "rg --vimgrep"
vim.o.wildignorecase = true
vim.o.wildmode = "longest:full,full"
vim.opt.wildoptions = { "pum", "fuzzy" }
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.o.swapfile = false
vim.o.undofile = true
vim.g.netrw_banner = 0
vim.g.vimtex_view_general_viewer = "evince"
vim.g.vimtex_quickfix_mode = 0

function _G.my_find(text, _)
	local files = {}
	local git_files = vim.fn.systemlist("git ls-files --cached --others --exclude-standard 2>/dev/null")

	if vim.v.shell_error == 0 then
		files = git_files
	else
		files = vim.tbl_filter(function(path)
			return vim.fn.isdirectory(path) == 0
		end, vim.fn.glob("**/*", true, true))
	end

	if text == "" then
		return files
	end

	return vim.fn.matchfuzzy(files, text)
end
vim.opt.findfunc = "v:lua.my_find"
