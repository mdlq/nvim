_G.M = {}

local api = vim.api
local util = vim.lsp.util
local handlers = vim.lsp.handlers
local lfunctions = require("functions").user

local location_handler = function(_, method, result)
	if #method < 1 then
		return
	else
		if
			method[1]["targetUri"] == result["params"]["textDocument"]["uri"]
			or method[1]["uri"] == result["params"]["textDocument"]["uri"]
		then
			util.jump_to_location(method[1], "utf-8")
		else
			api.nvim_command("tabnew")
			util.jump_to_location(method[1], "utf-8")
		end
	end
end

handlers["textDocument/declaration"] = location_handler
handlers["textDocument/definition"] = location_handler
handlers["textDocument/typeDefinition"] = location_handler
handlers["textDocument/implementation"] = location_handler

M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
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
