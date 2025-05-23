local status_ok, calltree = pcall(require, "calltree")

if not status_ok then
  vim.notify("calltree not found!", vim.log.levels.ERROR)
  return
end

calltree.setup()
