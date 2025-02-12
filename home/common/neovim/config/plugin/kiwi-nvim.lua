local status_ok, kiwi = pcall(require, "kiwi")

if not status_ok then
	return
end

kiwi.setup()
