local core = require("ollama-nvim.core") -- Correctly requiring the core module
local setup = require("ollama-nvim.setup")

local M = {}

function M.setup()
	setup.setup_virtual_env()
end

function M.queryLLM()
	core.queryLLM()
end

vim.api.nvim_create_user_command("QueryLLM", M.queryLLM, { nargs = 0 })

vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("ollama-nvim.core").queryLLMWithPrompt()<CR>',
	{ noremap = true, silent = true }
)

return M
