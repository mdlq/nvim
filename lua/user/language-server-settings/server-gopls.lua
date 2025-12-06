local util = require("lspconfig").util

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gotmpl" },
	-- root_dir = util.root_pattern("go.mod", ".git"),
	single_file_support = true,
}
