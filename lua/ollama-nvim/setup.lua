local M = {}

local function setup_virtual_env_internal()
	local project_root = vim.fn.stdpath("data") .. "/lazy/ollama-nvim"
	local venv_path = project_root .. "/venv"
	local requirements_path = project_root .. "/requirements.txt"

	-- Check if the virtual environment already exists
	if vim.fn.isdirectory(venv_path) == 0 then
		-- Create the virtual environment
		vim.fn.system("python3 -m venv " .. venv_path)
		print("Virtual environment created at " .. venv_path)
	else
		print("Virtual environment already exists.")
	end

	-- Correct way to activate the virtual environment and install requirements
	local pip_install_command = "bash -c 'source "
		.. venv_path
		.. "/bin/activate && pip install -r "
		.. requirements_path
		.. "'"
	local result = vim.fn.system(pip_install_command)

	if vim.v.shell_error == 0 then
		print("Dependencies installed successfully.")
	else
		print("Failed to install dependencies: " .. result)
	end
end

-- Expose the setup_virtual_env function through the module
function M.setup_virtual_env()
	setup_virtual_env_internal()
end

return M
