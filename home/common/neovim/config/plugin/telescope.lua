local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local themes = require("telescope.themes")
local actions = require("telescope.actions")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope picker keymaps
local telescope_builtin_ok, telescope_builtin = pcall(require, "telescope.builtin")
if telescope_builtin_ok then
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

  map("n", "<leader>tt", telescope_builtin.resume, opts)
  map("n", "<leader>fw", telescope_builtin.live_grep, opts)
  map("n", "<leader>/", telescope_builtin.live_grep, opts)
  map("v", "<leader>/", function()
    local text = getVisualSelection()
    telescope_builtin.live_grep({ default_text = text })
  end, opts)
  map("n", "<leader><leader>", telescope_builtin.find_files, opts)
  map("n", "<leader>gs", telescope_builtin.git_status, opts)
  map("n", "<leader>gc", telescope_builtin.git_commits, opts)
  map("n", "<leader>fb", telescope_builtin.buffers, opts)
  map("n", "<leader>,", telescope_builtin.buffers, opts)
  map("n", "<leader>fm", telescope_builtin.marks, opts)
  map("n", "<leader>fo", telescope_builtin.oldfiles, opts)
  map("n", "<leader>sr", telescope_builtin.registers, opts)
  map("n", "<leader>sk", telescope_builtin.keymaps, opts)
  map("n", "<leader>sc", telescope_builtin.commands, opts)
  map("n", "<leader>j", telescope_builtin.jumplist, opts)
end

-- Internal telescope mappings
local telescope_mappings = {
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
    ["<C-q>"] = actions.send_to_loclist + actions.open_loclist,
    ["<M-q>"] = actions.send_selected_to_loclist + actions.open_loclist,
    ["<C-_>"] = actions.which_key,
  },
  n = {
    ["<esc>"] = actions.close,
    ["<CR>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,
    ["<C-t>"] = actions.select_tab,
    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
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
  },
}

local telescope_buffer_keymaps = {
  i = {
    ["<C-d>"] = actions.delete_buffer,
  },
  n = {
    ["dd"] = actions.delete_buffer,
  },
}

telescope.setup({
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    wrap_results = true,
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.50,
      },
      width = function(_, max_columns, _)
        return max_columns
      end,
      height = function(_, _, max_lines)
        return max_lines
      end,
    },
    mappings = telescope_mappings,
    borderchars = require("general.themes").get_border_chars(),
  },
  pickers = {
    buffers = {
      initial_mode = "normal",
      mappings = telescope_buffer_keymaps,
    },
    git_branches = {
      initial_mode = "normal",
    },
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

telescope.load_extension("fzf")
