_G.M = {}

local hl = vim.api.nvim_set_hl

function M.codedark()
	vim.cmd([[ colo codedark ]])
end

function M.github()
	require("github-theme").setup({
		comment_style = "italic",
		hide_end_of_buffer = true,
		sidebars = {},
		theme_style = "dimmed",
		dark_sidebar = true,
		transparent = true,
	})
end

function M.old_vscode()
	vim.cmd([[ colo vscode ]])
	hl(0, "BufferLineFill", { bg = "#1e1e1e" })
	hl(0, "BufferLineIndicatorSelected", { fg = "#0a7aca" })
	hl(0, "BufferLineDevIconLua", { bg = "#1e1e1e" })
	hl(0, "BufferLineCloseButton", { bg = "#1e1e1e" })
	hl(0, "BufferLineCloseButtonSelected", { bg = "#1e1e1e", bold = false })
	hl(0, "BufferLineBackground", { bg = "#1e1e1e" })
	hl(0, "BufferLineBufferSelected", { bold = true })
end

function M.vscode()
	local color = require("vscode.colors").get_colors()
	require("vscode").setup({
		-- Enable transparent background
		transparent = false,
		-- Enable italic comment
		italic_comments = true,
		-- Underline `@markup.link.*` variants
		underline_links = true,
		-- Disable nvim-tree background color
		disable_nvimtree_bg = true,
		-- Override colors (see ./lua/vscode/colors.lua)
		color_overrides = {
			--vscLineNumber = "#FFFFFF",
		},
		-- Override highlight groups (see ./lua/vscode/theme.lua)
		group_overrides = {
			Cursor = { fg = color.vscDarkBlue, bg = color.vscLightGreen, bold = true },
			BufferLineFill = { bg = "#1E1E1E" },
			BufferLineIndicatorSelected = { fg = "#0A7ACA" },
			BufferLineCloseButton = { bg = "#1e1e1e" },
			BufferLineCloseButtonSelected = { bg = "#1E1E1E", bold = false },
			BufferLineBackground = { bg = "#1E1E1E" },
			BufferLineBufferSelected = { bold = true },
		},
	})

	vim.cmd.colorscheme("vscode")
end

return M
