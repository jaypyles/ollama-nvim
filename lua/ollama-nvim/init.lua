local core = require("ollama-nvim.core")

local M = {}

function M.setup() end

function M.queryLLM()
	core.queryLLM()
end

return M
