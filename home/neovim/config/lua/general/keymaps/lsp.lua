local map = vim.keymap.set
local M = {}

-- need to remove lsp saga
local status_ok, _ = pcall(require, "lspsaga")

if status_ok then
  local function lspsaga_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    map({ "n", "v" }, "K", vim.lsp.buf.hover, opts)
    -- map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    -- map("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)
    map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    map("n", "<leader>cl", vim.lsp.codelens.run, opts)

    map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

    if client.supports_method "textDocument/formatting" then
      map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, opts)
      map({ "n", "v" }, "Q", vim.lsp.buf.format, opts)
    end

    map("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)
    -- map("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
    -- map("n", "gr", "<cmd>Lspsaga rename ++project<CR>", opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)

    -- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    -- map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    map("n", "gl", vim.diagnostic.open_float, opts)

    -- map("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    -- map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    -- map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    -- map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    --
    -- map("n", "[E", function()
    --   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    -- end, opts)
    -- map("n", "]E", function()
    --   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    -- end, opts)

    map("n", "[e", vim.diagnostic.goto_prev, opts)
    map("n", "]e", vim.diagnostic.goto_next, opts)

    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)

    -- Toggle outline
    map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
    map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
    map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
  end

  M.lsp_keymaps = lspsaga_keymaps
else
  local function lsp_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- map({ "n", "v" }, "<leader>k", vim.lsp.buf.hover, opts)
    map({ "n", "v" }, "K", vim.lsp.buf.hover, opts)
    -- map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
    -- map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    -- map("n", "<leader>c", find_and_run_codelens, opts)
    map("n", "<leader>cl", vim.lsp.codelens.run, opts)

    -- print(vim.inspect(client))

    if client.supports_method "textDocument/formatting" then
      map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, opts)
      map({ "n", "v" }, "Q", vim.lsp.buf.format, opts)
    end

    map("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>lr", vim.lsp.buf.rename, opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gl", vim.diagnostic.open_float, opts)
    map("n", "[e", vim.diagnostic.goto_prev, opts)
    map("n", "]e", vim.diagnostic.goto_next, opts)
  end

  M.lsp_keymaps = lsp_keymaps
end

return M

