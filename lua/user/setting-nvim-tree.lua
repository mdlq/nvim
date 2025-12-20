local function get_center_config()
	local screen_w = vim.opt.columns:get()
	local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()

	-- Define your desired window width and height ratios (e.g., 80% of screen)
	local WIDTH_RATIO = 0.8
	local HEIGHT_RATIO = 0.8

	local window_w_int = math.floor(screen_w * WIDTH_RATIO)
	local window_h_int = math.floor(screen_h * HEIGHT_RATIO)

	-- Calculate top-left corner coordinates for centering
	local center_x = (screen_w - window_w_int) / 2
	local center_y = ((vim.opt.lines:get() - window_h_int) / 2) - vim.opt.cmdheight:get()

	return {
		border = "rounded", -- Optional: use "single", "double", "shadow", etc.
		relative = "editor",
		row = center_y,
		col = center_x,
		width = window_w_int,
		height = window_h_int,
	}
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	--vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
	--vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	sort_by = "name",
	sync_root_with_cwd = false,
	view = {
		--[[ centralize_selection = false,
		adaptive_size = false,
		width = 40,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		side = "left", ]]
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = get_center_config,
		},
	},
	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		timeout = 400,
	},
	tab = {
		sync = {
			open = true,
			close = true,
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = true,
		full_name = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	diagnostics = {
		enable = true,
		icons = {
			error = "󰅚 ",
			warning = " ",
			hint = "󰌶 ",
			info = " ",
		},
	},
	update_focused_file = {
		enable = true,
		update_root = false,
	},
})
