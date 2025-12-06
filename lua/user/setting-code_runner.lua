require("code_runner").setup({
	mode = "term",
	focus = true,
	startinsert = false,
	term = {
		position = "bot",
		size = 20,
	},
	filetype_path = vim.fn.expand("~/.config/nvim/code_runner.json"),
	-- project_path = vim.fn.expand("~/.config/nvim/project_manager.json"),
})
