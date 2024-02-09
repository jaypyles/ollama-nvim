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

	-- Define the path to your Python script
	local python_script_path = project_root .. "/scripts/query_llm.py"
	local python_interpreter = project_root .. "/venv/bin/python"

	-- Escape single quotes in combined_text
	local escaped_combined_text = combined_text:gsub("'", "'\\''")

	-- Command to call the Python script with combined_text as an argument
	-- Use a shell to correctly handle the inline argument
	local command = string.format("'%s' '%s' '%s'", python_interpreter, python_script_path, escaped_combined_text)
	local win = vim.api.nvim_get_current_win()
	local curr_filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "filetype")

	-- Define callback functions for handling the job's output and completion
	local on_stdout = function(job_id, data, event)
		local plugin = "ollama-nvim"
		vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, {
			title = plugin,
			on_open = function(win)
				local buf = vim.api.nvim_win_get_buf(win)
				vim.api.nvim_buf_set_option(buf, "filetype", curr_filetype)
			end,
		})
	end

	-- Start the job asynchronously
	vim.fn.jobstart(command, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = on_stdout,
		-- Use a shell to execute the command, enabling argument passing
		shell = "/bin/sh",
		shellcmdflag = "-c",
	})
end

return M
