local M = {}

function M.getSelectedText()
	-- Get the position of the start and end of the selection
	local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

	if start_row > end_row or (start_row == end_row and start_col > end_col) then
		-- If the start is after the end, swap them
		start_row, end_row = end_row, start_row
		start_col, end_col = end_col, start_col
	end

	-- Adjust the column indices to be 1-indexed
	start_col = start_col - 1
	end_col = end_col - 1

	-- Capture the selected text
	local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

	if #lines == 0 then
		return ""
	end
	lines[1] = string.sub(lines[1], start_col + 1)
	if start_row == end_row then
		lines[#lines] = string.sub(lines[1], 1, end_col - start_col)
	else
		lines[#lines] = string.sub(lines[#lines], 1, end_col + 1)
	end

	return table.concat(lines, "\n")
end

function M.queryLLM()
	local selected_text = M.getSelectedText()
	print("Selected text to send to LLM:", selected_text)
end

return M
