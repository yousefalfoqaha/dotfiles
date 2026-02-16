if vim.fn.executable("fd") == 1 then
	function _G.FdFindFunc(cmdarg, cmdcomplete)
		if cmdcomplete == 1 then
			return {}
		end

		local cmd = { "fd", "--type", "f", "--full-path", cmdarg }
		local result = vim.fn.systemlist(cmd)

		if vim.v.shell_error ~= 0 then
			vim.notify(table.concat(result, "\n"), vim.log.levels.ERROR)
			return {}
		end

		return result
	end

	vim.o.findfunc = "v:lua.FdFindFunc"
end
