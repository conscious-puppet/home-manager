local indent_blankline_status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not indent_blankline_status_ok then
  return
end

if vim.g.colors_name == "moonfly" then
  vim.cmd [[highlight IndentBlanklineContextChar guifg=#878787 gui=nocombine]]
end

indent_blankline.setup {
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
}

