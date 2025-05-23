local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
  vim.notify("Failed to load barbecue plugin", vim.log.levels.ERROR)
  return
end

barbecue.setup({
  show_modified = true,
})
