local M = {}

local mason_path = vim.fn.stdpath("data") .. "/mason"
local langs_path = vim.fn.stdpath("config") .. "/lua/packs/langs"

require("mason").setup()

local treesitter_parsers = {}
local formatters_by_ft = {}
local lsp_servers = {}
local mason_packages = {}

local files = vim.fn.glob(langs_path .. "/*.lua", false, true)
for _, file in ipairs(files) do
	local name = vim.fn.fnamemodify(file, ":t:r")
	local ok, pack = pcall(require, "packs.langs." .. name)

	if ok and pack then
		if pack.treesitter_parsers then
			for _, parser in ipairs(pack.treesitter_parsers) do
				treesitter_parsers[parser] = true
			end
		end

		if pack.lsp_configs then
			for k, v in pairs(pack.lsp_configs) do
				if type(k) == "number" and type(v) == "string" then
					lsp_servers[v] = {}
				elseif type(k) == "string" and type(v) == "table" then
					lsp_servers[k] = v
				end
			end
		end

		if pack.formatters_by_ft then
			for ft, fmts in pairs(pack.formatters_by_ft) do
				formatters_by_ft[ft] = fmts
			end
		end

		if pack.mason_install then
			for _, pkg in ipairs(pack.mason_install) do
				mason_packages[pkg] = true
			end
		end

		if pack.setup then
			pcall(pack.setup, mason_path)
		end
	end
end

local parsers = vim.tbl_keys(treesitter_parsers)
if #parsers > 0 then
	require("nvim-treesitter").install(parsers)
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

local missing_mason = {}
for pkg in pairs(mason_packages) do
	if vim.fn.isdirectory(mason_path .. "/packages/" .. pkg) == 0 then
		table.insert(missing_mason, pkg)
	end
end
if #missing_mason > 0 then
	vim.cmd("MasonInstall " .. table.concat(missing_mason, " "))
end

return M
