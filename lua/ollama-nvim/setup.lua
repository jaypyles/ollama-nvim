local M = {}

local function setup_virtual_env_internal()
	-- Dynamically determine the root path for the project installation
	local project_root = vim.fn.stdpath("data") .. "/lazy/ollama-nvim"
	local venv_path = project_root .. "/venv"
	local requirements_path = project_root .. "/requirements.txt"
	print(venv_path)

	-- Check if the virtual environment already exists
	if vim.fn.isdirectory(venv_path) == 0 then
		-- Create the virtual environment
		vim.fn.system("python3 -m venv " .. venv_path)
		print("Virtual environment created at " .. venv_path)
	else
		print("Virtual environment already exists.")
	end

	-- Activate the virtual environment and install requirements
	-- Note: This command may vary depending on your operating system and shell
	local activate_command = "bash source " .. venv_path .. "/bin/activate"
	local pip_install_command = activate_command .. " && pip install -r " .. requirements_path
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
