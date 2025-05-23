local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  vim.notify("fidget not found!", vim.log.levels.ERROR)
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
