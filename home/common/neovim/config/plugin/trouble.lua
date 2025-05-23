local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  vim.notify("trouble not found!", vim.log.levels.ERROR)
  return
end

trouble.setup({
  use_diagnostic_signs = true,
})
