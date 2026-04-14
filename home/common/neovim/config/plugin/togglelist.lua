local function toggle_quickfix()
  local qf_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end
  if qf_open then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

local function toggle_loclist()
  local ll_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.loclist == 1 then
      ll_open = true
      break
    end
  end
  if ll_open then
    vim.cmd.lclose()
  else
    pcall(vim.cmd.lopen)
  end
end

vim.keymap.set("n", "<leader>q", toggle_quickfix, { silent = true, desc = "Toggle Quickfix" })
vim.keymap.set("n", "<leader>l", toggle_loclist, { silent = true, desc = "Toggle Loclist" })
