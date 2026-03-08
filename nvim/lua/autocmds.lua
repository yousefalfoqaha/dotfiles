vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 100, visual = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local _ = pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		if not client then
			return
		end
		vim.lsp.completion.enable(true, client.id, bufnr, {
			-- autotrigger = true,
			convert = function(item)
				return { abbr = item.label:gsub("%b()", "") }
			end,
		})
		-- vim.api.nvim_create_autocmd("InsertCharPre", {
		-- 	buffer = bufnr,
		-- 	callback = vim.lsp.completion.get,
		-- })
	end,
})
