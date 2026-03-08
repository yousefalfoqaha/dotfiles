local M = {}

local state_file = vim.fn.stdpath("data") .. "/packs"
local mason_path = vim.fn.stdpath("data") .. "/mason"
local langs_path = vim.fn.stdpath("config") .. "/lua/packs/langs"

local enabled = {}

local function read_state()
	local set = {}
	local f = io.open(state_file, "r")
	if f then
		for line in f:lines() do
			local name = vim.trim(line)
			if name ~= "" then
				set[name] = true
			end
		end
		f:close()
	end
	return set
end

local function write_state()
	local f = io.open(state_file, "w")
	if f then
		local names = vim.tbl_keys(enabled)
		table.sort(names)
		for _, name in ipairs(names) do
			f:write(name .. "\n")
		end
		f:close()
	end
end

local function save_and_restart()
	write_state()
	vim.cmd("restart")
end

local function available_packs()
	local packs = {}
	local files = vim.fn.glob(langs_path .. "/*.lua", false, true)
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		table.insert(packs, name)
	end
	table.sort(packs)
	return packs
end

local function load_pack(name)
	local mod = "packs.langs." .. name
	package.loaded[mod] = nil
	local ok, pack = pcall(require, mod)
	if not ok then
		vim.notify("Pack '" .. name .. "' failed to load: " .. pack, vim.log.levels.ERROR)
		return nil
	end
	return pack
end

local function parse_lsp(lsp)
	local servers = {}
	for k, v in pairs(lsp) do
		if type(k) == "number" and type(v) == "string" then
			servers[v] = {}
		elseif type(k) == "string" and type(v) == "table" then
			servers[k] = v
		end
	end
	return servers
end

local function apply()
	local treesitter_parsers = {}
	local formatters_by_ft = {}
	local mason_packages = {}
	local lsp_servers = {}
	local setup_fns = {}

	for name in pairs(enabled) do
		local pack = load_pack(name)
		if pack then
			if pack.treesitter then
				for _, parser in ipairs(pack.treesitter) do
					treesitter_parsers[parser] = true
				end
			end

			if pack.lsp then
				for server, config in pairs(parse_lsp(pack.lsp)) do
					lsp_servers[server] = config
				end
			end

			if pack.formatters then
				for ft, fmts in pairs(pack.formatters) do
					formatters_by_ft[ft] = fmts
				end
			end

			if pack.mason then
				for _, pkg in ipairs(pack.mason) do
					mason_packages[pkg] = true
				end
			end

			if pack.setup then
				table.insert(setup_fns, { name = name, fn = pack.setup })
			end
		end
	end

	local parsers = vim.tbl_keys(treesitter_parsers)
	if #parsers > 0 then
		table.sort(parsers)
		require("nvim-treesitter").install(parsers)
	end

	for _, entry in ipairs(setup_fns) do
		local ok, err = pcall(entry.fn, mason_path)
		if not ok then
			vim.notify("Pack '" .. entry.name .. "' setup failed: " .. err, vim.log.levels.ERROR)
		end
	end

	local server_names = {}
	for server, config in pairs(lsp_servers) do
		if not vim.tbl_isempty(config) then
			vim.lsp.config(server, config)
		end
		table.insert(server_names, server)
	end
	if #server_names > 0 then
		vim.lsp.enable(server_names)
	end

	require("conform").setup({
		formatters_by_ft = formatters_by_ft,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})

	local missing = {}
	for pkg in pairs(mason_packages) do
		if vim.fn.isdirectory(mason_path .. "/packages/" .. pkg) == 0 then
			table.insert(missing, pkg)
		end
	end
	if #missing > 0 then
		table.sort(missing)
		vim.cmd("MasonInstall " .. table.concat(missing, " "))
	end
end

vim.api.nvim_create_user_command("PackEnable", function(opts)
	local names = vim.split(opts.args, "%s+", { trimempty = true })
	if #names == 0 then
		vim.notify("Usage: PackEnable <name> [name...]", vim.log.levels.WARN)
		return
	end

	local all = available_packs()
	local available_set = {}
	for _, p in ipairs(all) do
		available_set[p] = true
	end

	local added = {}
	for _, name in ipairs(names) do
		if not available_set[name] then
			vim.notify("Pack '" .. name .. "' not found", vim.log.levels.ERROR)
		elseif enabled[name] then
			vim.notify("Pack '" .. name .. "' already enabled", vim.log.levels.WARN)
		else
			enabled[name] = true
			table.insert(added, name)
		end
	end

	if #added > 0 then
		save_and_restart()
	end
end, {
	nargs = "+",
	complete = function(arglead)
		local all = available_packs()
		local results = {}
		for _, name in ipairs(all) do
			if not enabled[name] and name:find(arglead, 1, true) == 1 then
				table.insert(results, name)
			end
		end
		return results
	end,
})

vim.api.nvim_create_user_command("PackDisable", function(opts)
	local names = vim.split(opts.args, "%s+", { trimempty = true })
	if #names == 0 then
		vim.notify("Usage: PackDisable <name> [name...]", vim.log.levels.WARN)
		return
	end

	local removed = {}
	for _, name in ipairs(names) do
		if not enabled[name] then
			vim.notify("Pack '" .. name .. "' is not enabled", vim.log.levels.WARN)
		else
			enabled[name] = nil
			table.insert(removed, name)
		end
	end

	if #removed > 0 then
		save_and_restart()
	end
end, {
	nargs = "+",
	complete = function(arglead)
		local results = {}
		for name in pairs(enabled) do
			if name:find(arglead, 1, true) == 1 then
				table.insert(results, name)
			end
		end
		table.sort(results)
		return results
	end,
})

vim.api.nvim_create_user_command("PackClear", function()
	if vim.tbl_isempty(enabled) then
		vim.notify("No packs enabled", vim.log.levels.WARN)
		return
	end

	enabled = {}
	save_and_restart()
end, {})

vim.api.nvim_create_user_command("PackList", function()
	local all = available_packs()
	local lines = {}
	for _, name in ipairs(all) do
		local status = enabled[name] and "[x]" or "[ ]"
		table.insert(lines, status .. " " .. name)
	end
	if #lines == 0 then
		vim.notify("No packs available")
	else
		vim.notify("Language Packs:\n" .. table.concat(lines, "\n"))
	end
end, {})

require("mason").setup()
enabled = read_state()
if not vim.tbl_isempty(enabled) then
	apply()
end

return M
