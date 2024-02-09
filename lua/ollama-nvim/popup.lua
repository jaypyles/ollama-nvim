local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local function show_my_popup()
	local my_popup = Popup({
		border = {
			style = "rounded", -- or "single", "double", "shadow", etc.
			text = {
				top = "Popup Title",
				top_align = "center",
			},
		},
		type = "buf",
		position = "50%",
		size = {
			width = 40,
			height = 10,
		},
		enter = true,
		focusable = true,
		zindex = 50, -- ensures popup is above other UI components
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
