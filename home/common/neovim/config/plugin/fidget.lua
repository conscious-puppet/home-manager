local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	return
end

fidget.setup({
	window = {
		blend = 0,
	},
	text = {
		spinner = "dots",
	},
})
