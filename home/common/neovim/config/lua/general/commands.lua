local create_command = vim.api.nvim_create_user_command

local function woman()
  local telescope_builtin_status_ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not telescope_builtin_status_ok then
    return
  end
  telescope_builtin.man_pages({ previewer = false })
end

local function preview_notes()
  local telescope_builtin_status_ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not telescope_builtin_status_ok then
    return
  end
  telescope_builtin.find_files({ previewer = false, cwd = "~/notes/" })
end

create_command("Woman", woman, { desc = "Man Pages" })
create_command("Notes", preview_notes, { desc = "Search Notes" })
create_command("MYVIMRC", ":e $MYVIMRC", { desc = "Edit Neovim Config" })
create_command("CDC", ":cd %:p:h", { desc = "Change Global dir to current file" })
create_command("LDC", ":cd %:p:h", { desc = "Change Local dir to current file" })
create_command("Vterm", ":vsp | term", { desc = "Terminal in vertical split" })
create_command("Sterm", ":9sp | term", { desc = "Terminal in horizontal split" })
create_command("Nomodifiable", ":set noma", { desc = "Set no modifiable" })
create_command("Modifiable", ":set ma", { desc = "Set modifiable" })
-- create_command("Bufname", ":keepalt file", { desc = "Rename buffer" })
create_command("Filetype", ":set filetype", { desc = "Set filetype" })
-- command! -nargs=1 MyCommand call s:MyFunc(myParam)
create_command("CopyBufferFilepath", "let @+ = expand('%:p')", { desc = "Copy Buffer Filepath" })
create_command("TodoCapture", ":5sp ~/notes/todo.md", { desc = "Write to todo.md" })
create_command("WorkCapture", ":5sp ~/notes/work/work.md", { desc = "Write to work.md" })

create_command("WorkCapture", ":5sp ~/notes/work/work.md", { desc = "Write to work.md" })

create_command("Bonly", ":execute '%bdelete | edit # | normal `\"' | bdelete#", { desc = "Buffer only" })
create_command("LspClearLog", ":!cat /dev/null > ~/.local/state/nvim/lsp.log", { desc = "Clear LSP Logs" })

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

vim.cmd([[
  function! LocListToggle()
    if empty(filter(getwininfo(), 'v:val.loclist'))
      lopen
    else
      lclose
    endif
  endfunction
]])

vim.cmd([[
	:command -nargs=1 Bufname keepalt file <args>
	:command -nargs=1 Type set filetype <args>

  function! NewScratchTab(...)
      tabnew
      execute printf('set filetype=%s', a:1)
  endfunction

	:command -nargs=1 Scratch call NewScratchTab(<f-args>)
]])

vim.cmd([[
  function! CopyMessages(...)
      execute printf('redir @+')
      execute printf('%smessage', a:1)
      execute printf('redir END')
  endfunction

	:command -nargs=1 CopyMessages call CopyMessages(<f-args>)
]])
