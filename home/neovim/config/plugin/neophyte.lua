local status_ok, neophyte = pcall(require, "neophyte")

if not status_ok then
	return
end

neophyte.setup({
	-- font_size = {
	--   kind = 'width', -- 'width' | 'height'
	--   size = 10,
	-- },
	-- Multipliers of the base animation speed.
	-- To disable animations, set these to large values like 1000.
	cursor_speed = 2,
	scroll_speed = 2,
	-- Increase or decrease the distance from the baseline for underlines.
	underline_offset = 1,
})

vim.opt.guifont = "JetBrainsMono Nerd Font"

vim.keymap.set("n", "<c-+>", function()
	neophyte.set_font_width(neophyte.get_font_width() + 1)
end)

-- Decrease font size
vim.keymap.set("n", "<c-->", function()
	neophyte.set_font_width(neophyte.get_font_width() - 1)
end)
