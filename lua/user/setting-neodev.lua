require("neodev").setup({
	library = {
		enabled = true,
		runtime = true,
		types = true,
		plugins = { "nvim-cmp", "neodev.nvim" }, -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
	},
	setup_jsonls = true,
	override = function(_, _) end, -- function(root_dir, options)
	lspconfig = true,
	pathStrict = true,
})
