vim.keymap.set("n", "<leader>o", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end)

vim.keymap.set("n", "<leader>g", ":copen | :silent :gr! ")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<leader>pe", ":PackEnable ")
vim.keymap.set("n", "<leader>pd", ":PackDisable ")
vim.keymap.set("n", "<leader>pl", function()
	vim.cmd("PackList")
end)
vim.keymap.set("n", "<leader>pc", function()
	vim.cmd("PackClear")
end)
