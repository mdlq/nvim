local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local excluded_filetypes = {
	"c",
	"cpp",
	"python",
}

local clang_format_file_default = vim.fn.stdpath("config") .. "/config/clang-format"
local clang_format_file = vim.fn.getcwd() .. "/.clang-format"
local clang_format = ""
if vim.fn.empty(vim.fn.glob(clang_format_file)) == 1 then
	clang_format = "file:" .. clang_format_file_default
else
	clang_format = "file:" .. clang_format_file
end

null_ls.setup({
	sources = {
		formatting.gofmt,
		formatting.prettierd.with({
			extra_args = function()
				local args = { nil, "--print-width=80" }
				if vim.bo.filetype == "json" or vim.bo.filetype == "jsonc" or vim.bo.filetype == "yaml" then
					table.insert(args, 1, "--tab-width=2")
				else
					table.insert(args, 1, "--tab-width=4")
				end
				return args
			end,
			-- extra_filetypes = { "php" }, -- not work
		}),
		formatting.prettier.with({ -- use this for php only
			filetypes = { "php" },
			extra_args = { "--print-width=80" },
		}),
		formatting.stylua,
		formatting.black.with({
			extra_args = { "--fast", "--line-length=80" },
		}),
		formatting.clang_format.with({
			extra_args = {
				"-style",
				clang_format,
			},
		}),
	},
	on_attach = function(client, bufnr)
		-- Format On Save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					local isFormat = nil

					local function format()
						vim.lsp.buf.format({ bufnr = bufnr })
					end

					if #excluded_filetypes > 0 then
						for _, k in pairs(excluded_filetypes) do
							if k == vim.bo.filetype then
								isFormat = false
								break
							else
								isFormat = true
							end
						end
					else
						isFormat = true
					end

					if isFormat then
						format()
					end
				end,
			})
		end
	end,
})
