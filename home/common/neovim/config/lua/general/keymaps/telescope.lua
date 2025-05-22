local M = {}
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- M.on_attach = function(client, bufnr)
local _, telescope = pcall(require, "telescope.builtin")
local _, actions = pcall(require, "telescope.actions")

local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

M.telescope_picker_mapping = function()
  map("n", "<leader>tt", telescope.resume, opts)
  map("n", "<leader>fw", telescope.live_grep, opts)
  map("n", "<leader>/", telescope.live_grep, opts)
  map("v", "<leader>/", function()
    local text = getVisualSelection()
    telescope.live_grep({ default_text = text })
  end, opts)
  map("n", "<leader><leader>", telescope.find_files, opts)
  -- map("n", "<leader><leader>", telescope.find_files, opts, { hidden = true })
  map("n", "<leader>gs", telescope.git_status, opts)
  -- map("n", "<leader>gb", telescope.git_branches, opts)
  map("n", "<leader>gc", telescope.git_commits, opts)
  map("n", "<leader>fb", telescope.buffers, opts)
  map("n", "<leader>,", telescope.buffers, opts)
  map("n", "<leader>fm", telescope.marks, opts)
  map("n", "<leader>fo", telescope.oldfiles, opts)
  map("n", "<leader>sc", telescope.registers, opts)
  map("n", "<leader>sk", telescope.keymaps, opts)
  map("n", "<leader>sc", telescope.commands, opts)
  -- <leader>l is used by loc-list
  -- map("n", "<leader>ls", telescope.lsp_document_symbols, opts)
  -- map("n", "<leader>lR", telescope.lsp_references, opts)
  -- map("n", "<leader>lD", telescope.diagnostics, opts)
  map("n", "<leader>j", telescope.jumplist, opts)
end

M.telescope_mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-l>"] = actions.cycle_history_next,
    ["<C-h>"] = actions.cycle_history_prev,
    ["<C-c>"] = actions.close,
    ["<Down>"] = actions.move_selection_next,
    ["<Up>"] = actions.move_selection_previous,
    ["<CR>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,
    ["<C-t>"] = actions.select_tab,
    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,
    ["<PageUp>"] = actions.results_scrolling_up,
    ["<PageDown>"] = actions.results_scrolling_down,
    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    -- ["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
    -- ["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-q>"] = actions.send_to_loclist + actions.open_loclist,
    ["<M-q>"] = actions.send_selected_to_loclist + actions.open_loclist,
    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    -- ["<C-n>"] = actions.cycle_history_next,
    -- ["<C-p>"] = actions.cycle_history_prev,
    -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
    -- ["<C-l>"] = actions.complete_tag,
  },

  n = {
    ["<esc>"] = actions.close,
    ["<CR>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,
    ["<C-t>"] = actions.select_tab,
    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    -- ["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
    -- ["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-q>"] = actions.send_to_loclist + actions.open_loclist,
    ["<M-q>"] = actions.send_selected_to_loclist + actions.open_loclist,
    ["j"] = actions.move_selection_next,
    ["k"] = actions.move_selection_previous,
    ["<C-l>"] = actions.cycle_history_next,
    ["<C-h>"] = actions.cycle_history_prev,
    ["<Down>"] = actions.move_selection_next,
    ["<Up>"] = actions.move_selection_previous,
    ["gg"] = actions.move_to_top,
    ["G"] = actions.move_to_bottom,
    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,
    ["<PageUp>"] = actions.results_scrolling_up,
    ["<PageDown>"] = actions.results_scrolling_down,
    ["?"] = actions.which_key,
    -- ["H"] = actions.move_to_top,
    -- ["M"] = actions.move_to_middle,
    -- ["L"] = actions.move_to_bottom,
    -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
  },
}

M.telescope_buffer_keymaps = {
  i = {
    ["<C-d>"] = actions.delete_buffer,
  },
  n = {
    ["dd"] = actions.delete_buffer,
  },
}

return M
