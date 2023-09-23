local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()


local border = cmp.config.window.bordered()
border.border = vim.g.border_style
border.winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-h>"] = cmp.mapping.scroll_docs(-4),
    ["<C-l>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
    -- ["<leader>"] = cmp.mapping.confirm { select = false },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lua = "[LSP]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
  },
  window = {
    documentation = border,
    completion = border
  },
}

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(
--     {
--       ["<C-j>"] = cmp.mapping.preset.cmdline()["<Tab>"],
--       ["<C-k>"] = cmp.mapping.preset.cmdline()["<S-Tab>"],
--     }
--   ),
--   sources = {
--     { name = 'buffer' }
--   },
--   formatting = {
--     fields = { "abbr" },
--   },
-- })
--
-- cmp.setup.cmdline('?', {
--   mapping = cmp.mapping.preset.cmdline(
--     {
--       ["<C-j>"] = cmp.mapping.preset.cmdline()["<Tab>"],
--       ["<C-k>"] = cmp.mapping.preset.cmdline()["<S-Tab>"],
--     }
--   ),
--   sources = {
--     { name = 'buffer' }
--   },
--   formatting = {
--     fields = { "abbr" },
--   },
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--
-- cmp.setup.cmdline(':', {
--   -- completion = { autocomplete = false },
--   mapping = cmp.mapping.preset.cmdline(
--     {
--       ["<C-j>"] = cmp.mapping.preset.cmdline()["<Tab>"],
--       ["<C-k>"] = cmp.mapping.preset.cmdline()["<S-Tab>"],
--     }
--   ),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   }),
--   formatting = {
--     fields = { "abbr" },
--   },
-- })

-- print(vim.inspect(cmp))

