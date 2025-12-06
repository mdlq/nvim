local util = require("lspconfig").util

return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	--[[ root_dir = function(fname)
		return util.root_pattern("composer.json", ".git")(fname) or util.path.dirname(fname)
	end, ]]
}
