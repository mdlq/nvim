-- Language Server for Typst

vim.lsp.config("tinymist", {
	offset_encoding = "utf-8",
	-- https://github.com/Myriad-Dreamin/tinymist/blob/ce5ab817604c84227df8da2b30c34918654807ee/editors/neovim/Configuration.md
	settings = {
		formatterMode = "typstyle",
		exportPdf = false,
		semanticTokens = "disable",
		outputPath = vim.fn.getcwd() .. "/build/",
		rootPath = vim.fn.getcwd(),
	},
})
