local disable_formatting = vim.g.disable_formatting
disable_formatting.pyright = true
vim.g.disable_formatting = disable_formatting

local status_ok, conform = pcall(require, "conform")

if status_ok then
  vim.keymap.set({"n", "v"}, "Q", conform.format, { buffer = true, noremap = true })
end

