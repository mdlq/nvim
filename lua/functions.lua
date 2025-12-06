_G.M = {}

function M.init()
	vim.cmd([[
    function! SnipRun()
        let caret = winsaveview()
        %SnipRun
        call winrestview(caret)
    endfunction
    ]])
end

M.user = {}

function M.user.sniprun()
	vim.cmd([[
    call SnipRun()
    ]])
end

function M.user.closerunner()
	vim.cmd("SnipClose")
	vim.cmd("RunClose")
end

local function get_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return { row = cursor[1], col = cursor[2] }
end

function M.user.get_visual_selection() end

function M.user.range_format()
	local vpos = vim.fn.getpos("v")
	local begin_pos = { row = vpos[2], col = vpos[3] - 1 }
	local end_pos = get_cursor()
	local start_row
	local end_row
	if (begin_pos.row < end_pos.row) or ((begin_pos.row == end_pos.row) and (begin_pos.col <= end_pos.col)) then
		start_row = begin_pos
		end_row = end_pos
	else
		start_row = end_pos
		end_row = begin_pos
	end
	vim.lsp.buf.format({
		range = {
			["start"] = { start_row.row, start_row.col },
			["end"] = { end_row.row, end_pos.col },
		},
		async = true,
	})
end

return M
