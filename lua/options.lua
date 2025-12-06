vim.o.background = "dark"

-- global
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

-- opt
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.so = 5
vim.opt.splitright = false
vim.opt.scrollback = 10000
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.clipboard:append("unnamedplus")

vim.diagnostic.config({
	update_in_insert = true,
})
