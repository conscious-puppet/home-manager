local create_command = vim.api.nvim_create_user_command

local function woman()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    builtin.man_pages({ previewer = false })
  end
end

local function preview_notes()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    builtin.find_files({ previewer = false, cwd = "~/notes/" })
  end
end

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
    vim.cmd.lopen()
  end
end

create_command("Woman", woman, { desc = "Man Pages" })
create_command("Notes", preview_notes, { desc = "Search Notes" })
create_command("MYVIMRC", ":e $MYVIMRC", { desc = "Edit Neovim Config" })
create_command("CDC", ":cd %:p:h", { desc = "Change Global dir to current file" })
create_command("LDC", ":lcd %:p:h", { desc = "Change Local dir to current file" })
create_command("Vterm", ":vsp | term", { desc = "Terminal in vertical split" })
create_command("Sterm", ":9sp | term", { desc = "Terminal in horizontal split" })
create_command("Nomodifiable", ":set noma", { desc = "Set no modifiable" })
create_command("Modifiable", ":set ma", { desc = "Set modifiable" })
create_command("Filetype", ":set filetype", { desc = "Set filetype" })
create_command("CopyBufferFilepath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy Buffer Filepath" })
create_command("TodoCapture", ":5sp ~/notes/todo.md", { desc = "Write to todo.md" })
create_command("WorkCapture", ":5sp ~/notes/work/work.md", { desc = "Write to work.md" })

create_command("Bonly", function()
  local current = vim.fn.bufnr("%")
  vim.cmd("%bdelete")
  vim.cmd("buffer " .. current)
end, { desc = "Buffer only" })

create_command("LspClearLog", function()
  local log_path = vim.fn.stdpath("state") .. "/lsp.log"
  io.open(log_path, "w"):close()
end, { desc = "Clear LSP Logs" })

create_command("QuickFixToggle", toggle_quickfix, { desc = "Toggle Quickfix List" })
create_command("LocListToggle", toggle_loclist, { desc = "Toggle Location List" })

create_command("Bufname", function(opts)
  vim.cmd("keepalt file " .. opts.args)
end, { nargs = 1, desc = "Rename buffer" })

create_command("Type", function(opts)
  vim.bo.filetype = opts.args
end, { nargs = 1, desc = "Set filetype" })

create_command("Scratch", function(opts)
  vim.cmd.tabnew()
  vim.bo.filetype = opts.args
end, { nargs = 1, desc = "New scratch tab" })

create_command("CopyMessages", function(opts)
  vim.cmd("redir @+")
  vim.cmd(opts.args .. "message")
  vim.cmd("redir END")
end, { nargs = 1, desc = "Copy messages to clipboard" })

local function toggle_zen()
  if vim.g.zen_mode then
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes"
    vim.opt.wrap = false
    vim.g.zen_mode = false
  else
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "no"
    vim.opt.wrap = true
    vim.g.zen_mode = true
  end
end

create_command("Zen", toggle_zen, { desc = "Toggle zen mode" })
