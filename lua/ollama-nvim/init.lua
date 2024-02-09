local core = require("ollama-nvim.core") -- Make sure this path matches your plugin's structure

local M = {}

function M.setup() end

function M.queryLLM()
	core.queryLLM()
end

vim.api.nvim_create_user_command("QueryLLM", core.queryLLM, { nargs = 0 })

vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("yourplugin.core").queryLLMWithPrompt()<CR>',
	{ noremap = true, silent = true }
)

return M
