local colors = {
	fg = "#161616",
	--bg = "#121212",
	bg = nil,
	white = "#ffffff",
	black = "#161616",
	red = "#f44747",
	green = "#4EC9B0",
	blue = "#0a7aca",
	lightblue = "#5CB6F8",
	yellow = "#ffaf00",
	pink = "#DDB6F2",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		component_separators = "",
		section_separators = "",
		always_divide_middle = true,
		globalstatus = true,
		disabled_filetypes = {},
		refresh = {
			statusline = 100, -- default: 1000
		},
		theme = {
			normal = {
				a = { bg = colors.bg },
				b = { bg = colors.bg },
				c = { bg = colors.bg },
				x = { bg = colors.bg },
				y = { bg = colors.bg },
				z = { bg = colors.bg },
			},
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

local function color_by_mode()
	local mode_color_bg = {
		n = colors.blue,
		v = colors.yellow,
		V = colors.yellow,
		i = colors.green,
		r = colors.red,
		R = colors.red,
		c = colors.pink,
	}
	local mode_color_fg = {
		n = colors.fg,
		v = colors.fg,
		V = colors.fg,
		i = colors.fg,
		r = colors.fg,
		c = colors.fg,
	}
	return { fg = mode_color_fg[vim.fn.mode()], bg = mode_color_bg[vim.fn.mode()], gui = "bold" }
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 0, right = 0 },
})

ins_left({
	"mode",
})

ins_left({
	"branch",
})

ins_left({
	"filetype",
	colored = true,
	icon_only = true,
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	padding = { left = 0 },
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" }, -- error, warn, info, hint
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
	update_in_insert = true,
	always_visible = false,
})

ins_right({
	function()
		local username = vim.g.USER
		local hostname = vim.fn.hostname()
		return string.format("%s@%s", username, hostname)
	end,
})

ins_right({
	"o:encoding",
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.cyan },
})

ins_right({
	"progress",
})

ins_right({
	"location",
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 0, right = 0 },
})

require("lualine").setup(config)
