_G.M = {}

local lfunctions = require("functions").user

local function definition_new_tab()
	local params = vim.lsp.util.make_position_params(0, "utf-8")

	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, _)
		if err or not result or vim.tbl_isempty(result) then
			vim.notify("Definition not found", vim.log.levels.INFO)
			return
		end

		-- Create a new tab
		vim.cmd("tabedit")

		-- Result can be a single Location or a list (Location[] or LocationLink[])
		local target = vim.islist(result) and result[1] or result

		-- The 0.11+ replacement for jump_to_location
		-- show_document handles the buffer loading and cursor positioning
		vim.lsp.util.show_document(target, "utf-16", { focus = true })
	end)
end

M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", definition_new_tab, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
	vim.keymap.set("v", "<C-\\>f", lfunctions.range_format, bufopts)

	-- Disable lspconfig formatter
	client.server_capabilities.documentFormattingProvider = false
end

M.default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
