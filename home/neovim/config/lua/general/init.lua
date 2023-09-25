require "general.options"
require "general.autocmds"
require "general.commands"
require "general.keymaps.general"
require "general.lsp"
require "general.themes".set()

local relative_source = function(dir)
  local paths = vim.split(vim.fn.glob("~/.config/nvim/lua/" .. dir .. "/*.lua"), "\n")
  for _, file in pairs(paths) do
    vim.cmd('source ' .. file)
  end
end

relative_source("plugin")
relative_source("ftplugin")
