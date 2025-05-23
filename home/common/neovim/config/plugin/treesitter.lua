local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  vim.notify("nvim-treesitter.configs not found!", vim.log.levels.ERROR)
  return
end

configs.setup({
  modules = {},
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
  },
})
