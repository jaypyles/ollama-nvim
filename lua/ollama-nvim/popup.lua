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
			print("Value submitted: ", value)
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
	local event = require("nui.utils.autocmd").event

	response:on({ event.BufLeave }, function()
		local prompt_text = vim.api.nvim_buf_get_lines(prompt.bufnr, 0, -1, false)
		require("ollama-nvim.core").queryLLMWithPrompt(text, prompt_text)
		response:unmount()
	end, { once = true })
end

return {
	show_my_popup = test_layout,
}
