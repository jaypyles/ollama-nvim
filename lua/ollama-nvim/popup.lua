local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local function show_my_popup()
	local my_popup = Popup({
		position = "50%",
		size = {
			width = 80,
			height = 40,
		},
		enter = true,
		focusable = true,
		zindex = 50,
		relative = "editor",
		border = {
			padding = {
				top = 2,
				bottom = 2,
				left = 3,
				right = 3,
			},
			style = "rounded",
			text = {
				top = " I am top title ",
				top_align = "center",
				bottom = "I am bottom title",
				bottom_align = "left",
			},
		},
		buf_options = {
			modifiable = true,
			readonly = false,
		},
		win_options = {
			winblend = 10,
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	})

	-- Set content of the popup window
	my_popup:mount()
	my_popup:set_lines({ "Line 1", "Line 2", "Line 3" }) -- Example content

	-- Optional: Add keymaps for closing the popup
	my_popup:map("n", "<Esc>", function()
		my_popup:unmount()
	end, { noremap = true })
end

return {
	show_my_popup = show_my_popup,
}
