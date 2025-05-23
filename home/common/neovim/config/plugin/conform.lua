local status_ok, conform = pcall(require, "conform")

if not status_ok then
  vim.notify("conform not found!", vim.log.levels.ERROR)
  return
end

conform.setup({
  formatters_by_ft = {
    python = { "isort", "black" },
  },
})
