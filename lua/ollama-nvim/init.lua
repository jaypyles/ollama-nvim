local core = require("ollama-nvim.core") -- Correctly requiring the core module

local M = {}

function M.setup()
	-- Setup function for your plugin, if needed
end

function M.queryLLM()
	core.queryLLM()
end

-- Create the user command "QueryLLM"
vim.api.nvim_create_user_command("QueryLLM", core.queryLLM, { nargs = 0 })

-- Set up a key mapping to trigger the queryLLM function with the selected text
-- Make sure the require path matches the actual plugin structure
vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("ollama-nvim.core").queryLLMWithPrompt()<CR>',
	{ noremap = true, silent = true }
)

return M
