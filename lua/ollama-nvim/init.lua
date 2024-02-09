local core = require("ollama-nvim.core") -- Make sure this path matches your plugin's structure

local M = {}

function M.setup() end

function M.queryLLM()
	core.queryLLM()
end

-- Assuming core.queryLLM is properly defined in the core module,
-- you should be able to create the user command like this:
vim.api.nvim_create_user_command("QueryLLM", core.queryLLM, { nargs = 0 })

vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("ollama-nvim.core").queryLLMWithPrompt()<CR>',
	{ noremap = true, silent = true }
)

return M
