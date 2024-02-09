local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local function create_scratch_buffer()
	local bufnr = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile") -- Makes it a temporary buffer
	vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe") -- Buffer is deleted when hidden
	vim.api.nvim_buf_set_option(bufnr, "swapfile", false) -- Disable swapfile for this buffer

	return bufnr
end

local function show_my_popup()
	local bufnr = create_scratch_buffer()
	local my_popup = Popup({
		border = {
			style = "rounded", -- or "single", "double", "shadow", etc.
			text = {
				top = "Popup Title",
				top_align = "center",
			},
		},
		position = "50%",
		size = {
			width = 40,
			height = 10,
		},
		buf_options = {
			modifiable = true,
			readonly = false,
		},
		enter = true,
		focusable = true,
		zindex = 50, -- ensures popup is above other UI components
		bufnr = bufnr,
	})

	-- Set content of the popup window
	my_popup:mount()

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Line 1", "Line 2", "Editable content here..." })

	-- Optional: Add keymaps for closing the popup
	my_popup:map("n", "<Esc>", function()
		my_popup:unmount()
	end, { noremap = true })
end

return {
	show_my_popup = show_my_popup,
}
