local M = {}
local ts_utils_status, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
local keymaps = require("general.keymaps.lsp")

M.setup = function()
  local signs = {
    -- { name = "DiagnosticSignError", text = "" },
    -- { name = "DiagnosticSignWarn", text = "" },
    -- { name = "DiagnosticSignHint", text = "" },
    -- { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "ﴞ" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- signs = {
    --   active = signs
    -- },
    signs = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = true,
    float = {
      border = vim.g.border_style,
      focusable = true,
      style = "minimal",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border_style })
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border_style })
  -- --
  -- local lite_lsp_handlers_status_ok, lite_lsp_handlers = pcall(require, "lite.lsp.handlers")
  -- if lite_lsp_handlers_status_ok then
  --   vim.lsp.handlers['callHierarchy/incomingCalls'] = vim.lsp.with(
  --     lite_lsp_handlers.ch_lsp_handler("from"), {}
  --   )
  --   vim.lsp.handlers['callHierarchy/outgoingCalls'] = vim.lsp.with(
  --     lite_lsp_handlers.ch_lsp_handler("to"), {}
  --   )
  -- end
end

local function highlight_references()
  local node
  if ts_utils_status then
    node = ts_utils.get_node_at_cursor()
  end
  while node ~= nil do
    local node_type = node:type()
    if
      node_type == "string"
      or node_type == "string_fragment"
      or node_type == "template_string"
      or node_type == "document" -- for inline gql`` strings
    then
      -- who wants to highlight a string? i don't. yuck
      return
    end
    node = node:parent()
  end
  vim.lsp.buf.document_highlight()
end

--- @return fun() @function that calls the provided fn, but with no args
local function w(fn)
  return function()
    return fn()
  end
end

---@param bufnr number
local function buf_autocmd_document_highlight(bufnr)
  local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = group,
    callback = highlight_references,
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.buf.clear_references),
  })
end

---@param bufnr number
local function buf_autocmd_codelens(bufnr)
  local group = vim.api.nvim_create_augroup("lsp_document_codelens", {})
  vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "CursorHold" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.codelens.refresh),
  })
end

-- Finds and runs the closest codelens (searches upwards only)
-- local function find_and_run_codelens()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--   local lenses = vim.lsp.codelens.get(bufnr)
--
--   lenses = vim.tbl_filter(function(lense)
--     return lense.range.start.line < row
--   end, lenses)
--
--   if #lenses == 0 then
--     return vim.notify "Could not find codelens to run."
--   end
--
--   table.sort(lenses, function(a, b)
--     return a.range.start.line > b.range.start.line
--   end)
--
--   vim.api.nvim_win_set_cursor(0, { lenses[1].range.start.line + 1, lenses[1].range.start.character })
--   vim.lsp.codelens.run()
--   vim.api.nvim_win_set_cursor(0, { row, col }) -- restore cursor, TODO: also restore position
-- end

M.on_attach = function(client, bufnr)
  if vim.g.disable_formatting[client.name] == true then
    client.server_capabilities.documentFormatting = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormatting = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  keymaps.lsp_keymaps(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  -- if client.supports_method "textDocument/documentHighlight" then
  --   buf_autocmd_document_highlight(bufnr)
  -- else
  --   vim.api.nvim_del_augroup_by_name("lsp_document_highlight")
  -- end

  if vim.g.disable_codelens[client.name] == false then
    if client.supports_method("textDocument/codeLens") then
      buf_autocmd_codelens(bufnr)
      vim.schedule(vim.lsp.codelens.refresh)
    end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
