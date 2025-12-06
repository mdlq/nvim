local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = require("user.language-server-settings.handler").on_attach

local servers = {
	"lua_ls",
	"gopls",
	-- "tsserver", # deprecated
	"ts_ls",
	"pyright",
	"rust_analyzer",
	"intelephense",
	"bashls",
	"clangd",
	"cssls",
	"emmet_ls",
	"html",
	"jdtls",
	"omnisharp",
	"jsonls",
	"yamlls",
	-- "denols",
	"texlab",
	"tinymist",
}

require("mason").setup({
	ui = {
		check_oudated_packages_on_open = true,
		border = nil,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
		keymaps = {
			toggle_package_expand = "<CR>",
			install_package = "i",
			update_package = "u",
			check_package_version = "c",
			update_all_packages = "U",
			check_outdated_packages = "C",
			uninstall_package = "X",
			cancel_installation = "<C-c>",
			apply_language_filter = "<C-f>",
		},
	},
	--install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },
	pip = {
		install_args = {},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	github = {
		download_url_template = "https://github.com/%s/releases/download/%s/%s",
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
	ensure_installed = servers,
	automatic_installation = false,
})

local function ls_prefix(name)
	return string.format("user.language-server-settings.server-%s", name)
end

local default_capabilities = require("user.language-server-settings.handler").default_capabilities
local function extend(ls, capabilities)
	capabilities = capabilities or default_capabilities
	local req = nil
	local ok, value = pcall(require, ls_prefix(ls))

	if ok then
		req = value
	else
		req = {}
	end

	return vim.tbl_deep_extend("force", req, {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150, -- default: 150
		},
		capabilities = capabilities,
	})
end

function lsp_setup(lsp, configs)
	vim.lsp.config[lsp] = configs
	vim.lsp.enable(servers)
end

-- local nvim_lsp = require("lspconfig")
local configs = nil
for _, lsp in pairs(servers) do
	if lsp == "clangd" then
		default_capabilities.offsetEncoding = "utf-8"
	elseif lsp == "denols" then
		configs = extend(lsp, {})
		goto skip
	elseif lsp == "jdtls" then
		goto skip
	--[[ elseif lsp == "rust_analyzer" then
		local rust_tools = require("rust-tools")
		local rust_tools_opts = require("user.language-server-settings.server-rust_tools")
		rust_tools.setup(rust_tools_opts)
		goto skip ]]
	elseif lsp == "tinymist" then
		require("user.language-server-settings.server-tinymist")
		goto skip
	end
	configs = extend(lsp)
	lsp_setup(lsp, configs)
	-- nvim_lsp[lsp].setup(configs)
	::skip::
end

-- vim.lsp.enable(servers)

--[[ local configs = extend(lsp)
vim.lsp.config("clangd", configs) ]]

-- Other Settings

-- Diagnostic Config
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})

-- Icons for Native LSP
local icons = require("icons").kinds
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = icons[kind] or kind
end

-- Diagnostic Symbols
local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
