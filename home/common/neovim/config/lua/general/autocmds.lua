vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.log", "*.purs" },
  callback = function(ev)
    local ext = ev.match:match("%.(%w+)$")
    if ext == "log" then
      vim.bo[ev.buf].filetype = "log"
    elseif ext == "purs" then
      vim.bo[ev.buf].filetype = "purescript"
    end
  end,
})

vim.api.nvim_create_augroup("neovim_terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = "neovim_terminal",
  callback = function()
    vim.cmd.startinsert()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = "neovim_terminal",
  callback = function(ev)
    vim.keymap.set("n", "<C-c>", "i<C-c>", { buffer = ev.buf })
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = "neovim_terminal",
  pattern = "zsh",
  callback = function()
    vim.cmd('call feedkeys("i")')
  end,
})
