return {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "php" },
	single_file_support = true,
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = false,
			},
		},
	},
}
