local file = vim.fn.stdpath("data") .. "/theme"

local groups = {
	"Normal",
	"NormalNC",
	"SignColumn",
	-- "EndOfBuffer",
	-- "LineNr",
	"CursorLineNr",
	-- "FoldColumn",
	-- "VertSplit",
	-- "StatusLine",
	-- "StatusLineNC",
	-- "TabLine",
	-- "TabLineFill",
	-- "Pmenu",
	-- "PmenuSel",
}

local f = io.open(file, "r")
if f then
	local name = f:read("*l")
	f:close()
	if name then
		pcall(vim.cmd.colorscheme, name)
	end
end

vim.api.nvim_create_user_command("Theme", function(opts)
	local name = opts.args
	if name == "" then
		return
	end
	if pcall(vim.cmd.colorscheme, name) then
		local wf = io.open(file, "w")
		if wf then
			wf:write(name)
			wf:close()
		end
	end

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end, {
	nargs = 1,
	complete = "color",
})

for _, group in ipairs(groups) do
	vim.api.nvim_set_hl(0, group, { bg = "none" })
end
