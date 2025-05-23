local status_ok, oil = pcall(require, "oil")

if not status_ok then
  vim.notify("oil not found!", vim.log.levels.ERROR)
  return
end

oil.setup()
