local util = require("lspconfig").util

return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose" },
	--[[ root_dir = function(fname)
		return util.root_pattern(".git")(fname) or util.path.dirname(fname)
	end, ]]
	settings = {
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
		yaml = {
			schemaStore = {
				enable = true,
				url = "https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json",
			},
		},
	},
	single_file_support = true,
}
