local core = require("ollama-nvim.core") -- Correctly requiring the core module
local setup = require("ollama-nvim.setup")
local popup = require("ollama-nvim.popup")

local M = {}

function M.setup()
	setup.setup_virtual_env()
end

function M.queryLLM()
	core.queryLLM()
end

vim.api.nvim_create_user_command("QueryLLM", M.queryLLM, { nargs = 0 })
vim.api.nvim_create_user_command("QueryLLMSetup", setup.setup_virtual_env, { nargs = 0 })
vim.api.nvim_create_user_command("TestPopup", popup.show_my_popup, { nargs = 0 })

vim.api.nvim_set_keymap(
	"v",
	"<leader>q",
	':lua require("ollama-nvim.popup").show_my_popup()<CR>',
	{ noremap = true, silent = true }
)

return M
