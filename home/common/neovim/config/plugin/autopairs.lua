-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  vim.notify("nvim-autopairs not found!", vim.log.levels.ERROR)
  return
end

npairs.setup({
  check_ts = true, -- Enable Treesitter integration
  ts_config = {
    lua = { "string", "source" }, -- Enable autopairs in Lua strings and source nodes
    javascript = { "string", "template_string" }, -- Enable in JS strings and template strings
    java = false, -- Disable for Java
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- Disable for specific filetypes
})

-- Integrate with nvim-cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
  return
end

local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_status_ok then
  vim.notify("nvim-autopairs.completion.cmp not found!", vim.log.levels.ERROR)
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

