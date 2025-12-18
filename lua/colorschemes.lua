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
	local cicon_error = "#F44747"
	local cicon_warn = "#DCDCAA"
	local cicon_info = "#569CD6"
	local cicon_hint = "#569CD6"
	local cdark = "#0f0f0f"
	local cdark_selected = "#1F1F1F"
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
			BufferLineFill = { bg = cdark },
			BufferLineIndicatorSelected = { fg = "#0A7ACA" },
			BufferLineCloseButton = { bg = cdark },
			BufferLineCloseButtonSelected = { bg = cdark_selected, bold = false },
			BufferLineBackground = { bg = cdark },
			BufferLineBufferSelected = { bg = cdark_selected, bold = true },
			BufferLineDevIconLua = { bg = cdark },
			BufferLineDevIconLuaSelected = { bg = cdark_selected },
			BufferLineOffsetSeparator = { bg = color.vscRed },

			BufferLineSeparator = { bg = color.vscYellow },
			BufferLineSeparatorVisible = { bg = color.vscYellow },
			BufferLineSeparatorSelected = { bg = color.vscYellow },

			-- Diagnostics
			BufferlineError = { bg = cdark, fg = cicon_error }, -- Filename container
			BufferlineErrorSelected = { bg = cdark_selected, fg = cicon_error, bold = true },
			BufferlineErrorDiagnostic = { bg = cdark, fg = cicon_error }, -- Icon container
			BufferlineErrorDiagnosticSelected = { bg = cdark_selected, fg = cicon_error, bold = true },

			BufferlineWarning = { bg = cdark, fg = cicon_warn }, -- Filename container
			BufferlineWarningSelected = { bg = cdark_selected, fg = cicon_warn, bold = true },
			BufferlineWarningDiagnostic = { bg = cdark, fg = cicon_warn }, -- Icon container
			BufferlineWarningDiagnosticSelected = { bg = cdark_selected, fg = cicon_warn, bold = true },

			BufferlineHint = { bg = cdark, fg = cicon_hint }, -- Filename container
			BufferlineHintSelected = { bg = cdark_selected, fg = cicon_hint, bold = true },
			BufferlineHintDiagnostic = { bg = cdark, fg = cicon_hint }, -- Icon container
			BufferlineHintDiagnosticSelected = { bg = cdark_selected, fg = cicon_hint, bold = true },

			BufferlineInfo = { bg = cdark, fg = cicon_info }, -- Filename container
			BufferlineInfoSelected = { bg = cdark_selected, fg = cicon_info, bold = true },
			BufferlineInfoDiagnostic = { bg = cdark, fg = cicon_info }, -- Icon container
			BufferlineInfoDiagnosticSelected = { bg = cdark_selected, fg = cicon_info, bold = true },
		},
	})

	vim.cmd.colorscheme("vscode")
end

return M
