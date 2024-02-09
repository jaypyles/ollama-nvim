local M = {}

function M.getSelectedText()
	local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

	start_col = start_col - 1
	end_col = end_col - 1

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

function M.queryLLMWithPrompt()
	local project_root = vim.fn.stdpath("data") .. "/lazy/ollama-nvim"
	local selected_text = M.getSelectedText()
	local prompt_text = vim.fn.input("PROMPT\n")
	local combined_text = prompt_text .. "\n" .. selected_text

	print("Combined text to send to LLM:", combined_text)

	-- Define the path to your Python script
	local python_script_path = project_root .. "/scripts/query_llm.py"

	-- Command to call the Python script with combined_text as an argument
	local command = string.format("python3 %s '%s'", python_script_path, combined_text)

	-- Call the Python script
	local result = vim.fn.system(command)

	-- Optional: Handle the output of the Python script
	print("Result from Python script:", result)
	-- Here, instead of printing, you would call your Python script or process the combined text as needed.
end

return M
