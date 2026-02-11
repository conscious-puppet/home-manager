vim.opt_local.iskeyword:append("'")

local cmp_status_ok, cmp = pcall(require, "cmp")

if cmp_status_ok then
  cmp.setup.filetype("haskell", {
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        option = {
          keyword_pattern = [[\k\+]],
        },
      },
      {
        name = "buffer",
        option = {
          keyword_pattern = [[\k\+]],
        },
      },
      { name = "path" },
    }),
  })
end
