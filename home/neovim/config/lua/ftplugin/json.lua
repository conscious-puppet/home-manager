vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json" },
  callback = function()
    -- local map = vim.keymap.set
    -- jq -R 'try fromjson catch .'
    -- -- map("n", "Q", "<cmd>%!jq .<CR>", { buffer = true, noremap = true })
    -- map("n", "Q", "<cmd>%!jq -R \"fromjson? | . \" -c | jq .<CR>", { buffer = true, noremap = true })
  end,
})
