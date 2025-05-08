local status_ok, obsidian = pcall(require, "obsidian")

if not status_ok then
	return
end

obsidian.setup {
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/obsidian",
    },
    {
      name = "work",
      path = "~/Documents/Obsidian Vault",
    },
  },
}
