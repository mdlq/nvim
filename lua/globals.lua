vim.g.USER = os.getenv("USER")

local latex_cwd = vim.fn.getcwd()

vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
	["aux_dir"] = latex_cwd .. "/.out/aux",
	["out_dir"] = latex_cwd .. "/.out/build",
}

-- Disable diagnostics window when there is only warnings and no errors
vim.g.vimtex_quickfix_open_on_warning = 0
