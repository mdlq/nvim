require("nvim-treesitter.configs").setup({
	ensure_installed = { -- A list of parser names, or "all"
		"go",
		"javascript",
		"typescript",
		"rust",
		"python",
		"php",
		"java",
		"lua",
		"c",
		"cpp",
		"vim",
		"sql",
		"html",
		"dockerfile",
		"bash",
		"json",
		"jsonc",
		"yaml",
		"gomod",
		"css",
	},
	sync_install = false, -- Install parsers synchronously (only applied to 'ensure_installed')
	ignore_install = { "" }, -- List of parsers to ignore installing (for "all")
	highlight = {
		enable = true,
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = { "yaml", "go", "rust", "c" },
	},
})
