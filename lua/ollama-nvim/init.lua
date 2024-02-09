local core = require("ollama-nvim.core") -- Make sure this path matches your plugin's structure

local M = {}

function M.setup()
	-- Setup function for your plugin, if needed
end

function M.queryLLM()
	core.queryLLM()
end

-- Create a Neovim command to query the LLM
vim.api.nvim_create_user_command("QueryLLM", core.queryLLM, { nargs = 0 })

-- Set up a key mapping to trigger the queryLLM function with the selected text
-- Make sure the require path matches the one used at the top
vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("ollama-nvim.core").queryLLM()<CR>',
	{ noremap = true, silent = true }
)

return M
