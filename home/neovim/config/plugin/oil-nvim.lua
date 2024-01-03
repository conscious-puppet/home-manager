local status_ok, oil = pcall(require, "oil")

if not status_ok then
  return
end

oil.setup()
