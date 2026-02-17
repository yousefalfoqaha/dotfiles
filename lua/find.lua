if vim.fn.executable("fzf") == 1 and vim.fn.executable("fd") == 1 then
	function _G.FzfFindFunc(cmdarg, cmdcomplete)
		if cmdcomplete == 1 then
			return {}
		end

		local cmd = string.format("fd --type f --strip-cwd-prefix | fzf --filter %s", vim.fn.shellescape(cmdarg))

		local result = vim.fn.systemlist(cmd)

		if vim.v.shell_error ~= 0 then
			return {}
		end

		return result
	end

	vim.o.findfunc = "v:lua.FzfFindFunc"
end
