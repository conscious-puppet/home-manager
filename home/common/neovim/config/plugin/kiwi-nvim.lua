local status_ok, kiwi = pcall(require, "kiwi")

if not status_ok then
  vim.notify("kiwi not found!", vim.log.levels.ERROR)
  return
end

kiwi.setup()
