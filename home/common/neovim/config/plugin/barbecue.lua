local status_ok, barbecue = pcall(require, "barbecue")

if not status_ok then
	return
end

barbecue.setup({
	show_modified = true,
})
