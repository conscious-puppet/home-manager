local _, rust_tools = pcall(require, "rust-tools")

local border = function()
  if vim.g.border_style == "single" then
    return {
      { "┌", "FloatBorder" },
      { "─", "FloatBorder" },
      { "┐", "FloatBorder" },
      { "│", "FloatBorder" },
      { "┘", "FloatBorder" },
      { "─", "FloatBorder" },
      { "└", "FloatBorder" },
      { "│", "FloatBorder" },
    }
  else
    return {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }
  end
end

local opts = {
  tools = {
    inlay_hints = {
      auto = false,
      only_current_line = false,
      show_parameter_hints = false,
    },
    hover_actions = {
      border = border(),
    },
  },
  server = {
    on_attach = require("general.lsp.handlers").on_attach,
    capabilities = require("general.lsp.handlers").capabilities,
  },
}

rust_tools.setup(opts)
