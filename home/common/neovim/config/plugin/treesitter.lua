-- Enable treesitter highlighting using Neovim's built-in API.
-- nvim-treesitter.configs was removed in nvim-treesitter 1.0+.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)
    if not ok then
      -- Parser not available for this filetype; silently skip.
    end
  end,
})
