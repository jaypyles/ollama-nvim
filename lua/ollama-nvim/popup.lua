local Layout = require("nui.layout")
local Popup = require("nui.popup")
local Input = require("nui.input")

local function make_prompt()
	local response = Popup({ border = "single" })
	local prompt_options = {
		relative = "cursor",
		position = {
			row = 1,
			col = 0,
		},
		size = 20,
		border = {
			style = "rounded",
			text = {
				top = "[Enter your prompt]",
				top_align = "left",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}
	local text = require("ollama-nvim.core").getSelectedText()
	local lines = {}
	for line in text:gmatch("([^\n]*)\n?") do
		table.insert(lines, line)
	end
	vim.api.nvim_buf_set_lines(response.bufnr, 0, -1, false, lines)

	local prompt = Input(prompt_options, {
		prompt = "> ",
		default_value = "",
		on_submit = function(value)
			require("ollama-nvim.core").queryLLMWithPrompt(text, value)
		end,
	})

	local layout = Layout(
		{
			position = "50%",
			size = {
				width = 80,
				height = 40,
			},
		},
		Layout.Box({
			Layout.Box(response, { size = "40%" }),
			Layout.Box({
				Layout.Box(prompt, { size = "100%" }),
			}, { dir = "row", size = "20%" }),
		}, { dir = "col" })
	)

	layout:mount()
end

return {
	make_prompt = make_prompt,
}
