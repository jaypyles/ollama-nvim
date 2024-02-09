local Layout = require("nui.layout")
local Popup = require("nui.popup")
local Input = require("nui.input")

local function test_layout()
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
				top = "[Input]",
				top_align = "left",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}
	local prompt = Input(prompt_options, { prompt = "> ", default_value = "" })

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

	local text = require("ollama-nvim.core").getSelectedText()

	layout:mount()
end

return {
	show_my_popup = test_layout,
}
