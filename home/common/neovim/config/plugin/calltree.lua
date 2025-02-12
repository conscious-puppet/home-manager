local status_ok, calltree = pcall(require, "calltree")

if not status_ok then
	return
end

calltree.setup()
