local util = require("lspconfig").util

return {
	cmd = { "deno", "lsp" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	init_options = {
		enable = true,
		unstable = false,
	},
	root = util.root_pattern("deno.json", "deno.jsonc", ".git"),
}
