vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local fname = vim.fn.expand("%:t")
if fname == "jsconfig.json" or fname == "tsconfig.json" then
	vim.bo.filetype = "jsonc"
end
