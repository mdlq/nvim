local functions = require("functions").user
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Modes:
--  normal_mode         = 'n'
--  insert_mode         = 'i'
--  visual_mode         = 'v'
--  visual_block_mode   = 'x'
--  term_mode           = 't'
--  command_mode        = 'c'

-- Neovim
keymap("n", "<C-p>\\", "<CMD>noh<CR>", opts)
-- Tab
keymap({ "n", "i", "c" }, "<C-l>", "<CMD>tabnext<CR>", opts)
keymap({ "n", "i", "c" }, "<C-h>", "<CMD>tabprevious<CR>", opts)
keymap({ "n", "i", "c" }, "<C-S-l>", "<CMD>tabm +1<CR>", opts)
keymap({ "n", "i", "c" }, "<C-S-h>", "<CMD>tabm -1<CR>", opts)

-- Open Link
if vim.fn.has("mac") == 1 then
	keymap("n", "gx", '<CMD>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>', opts)
elseif vim.fn.has("unix") == 1 then
	keymap("n", "gx", '<CMD>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', opts)
else
	keymap("n", "gx", '<CMD>lua print("Error: gx is not supported on this OS!")<CR>', opts)
end

-- Telescope
keymap("n", "<C-p>p", require("telescope.builtin").find_files, opts)
keymap("n", "<C-p>l", require("telescope.builtin").live_grep, opts)
keymap("n", "<C-p>b", require("telescope.builtin").buffers, opts)
keymap("n", "<C-p>s", require("telescope.builtin").grep_string, opts)
keymap("n", "<C-p>c", require("telescope.builtin").commands, opts)
keymap("n", "<C-p>f", require("telescope").extensions.file_browser.file_browser, opts)

-- Trouble
keymap("n", "<F4>", "<CMD>Trouble<CR>", opts)

-- Sniprun
keymap("n", "<F5>", functions.sniprun, opts)
keymap("n", "<F6>", "<CMD>SnipClose<CR>", opts)
--keymap("v", "<F5>", "<CMD>'<,'>SnipRun<cr>", opts)
--keymap("v", "<F6>", "<CMD>SnipClose<cr>", opts)

-- Nvim-Tree
keymap("n", "<C-\\>", "<CMD>NvimTreeToggle<cr>", opts)

-- code_runner
--keymap("n", "<F5>", "<CMD>RunFile<CR>", opts)
--keymap("n", "<F6>", functions.closerunner, opts)
