local util = require("lspconfig").util
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git"),
	single_file_support = true,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				disable = { "missing-fields" },
			},
			workspace = {
				checkThirdParty = false,
				-- use plugin "neodev.nvim" instead of "workspace = {}"
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
