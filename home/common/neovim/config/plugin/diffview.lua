local status_ok, diffview = pcall(require, "diffview")

if not status_ok then
  vim.notify("diffview not found!", vim.log.levels.ERROR)
  return
end

local actions = require("diffview.actions")
local lazy = require("diffview.lazy")
local StandardView = lazy.access("diffview.scene.views.standard.standard_view", "StandardView") ---@type StandardView|LazyModule
local lib = lazy.require("diffview.lib")
local git = lazy.require("diffview.git.utils")
local api = vim.api

-- local function git_prev_jump()
--   local view = lib.get_current_view()
--
--   if view and view:instanceof(StandardView.__get()) then
--     local main = view.cur_layout:get_main_win()
--     local curfile = main.file
--
--     if main:is_valid() and curfile:is_valid() then
--       local conflicts, _, cur_idx = git.parse_conflicts(
--         api.nvim_buf_get_lines(curfile.bufnr, 0, -1, false),
--         main.id
--       )
--
--       if #conflicts > 0 then
--         local prev_idx = (math.max(cur_idx, 1) - 2) % #conflicts + 1
--         local prev_conflict = conflicts[prev_idx]
--         local curwin = api.nvim_get_current_win()
--
--         api.nvim_win_call(main.id, function()
--           api.nvim_win_set_cursor(main.id, { prev_conflict.first, 0 })
--           if curwin ~= main.id then view.cur_layout:sync_scroll() end
--         end)
--
--         api.nvim_echo({ { ("Conflict [%d/%d]"):format(prev_idx, #conflicts) } }, false, {})
--       else
--         local max = -1
--         local target
--
--         for _, win in ipairs(view.cur_layout.windows) do
--           local c = api.nvim_buf_line_count(api.nvim_win_get_buf(win.id))
--           if c > max then
--             max = c
--             target = win.id
--           end
--         end
--
--         if target then
--           api.nvim_win_call(target, function()
--             vim.cmd [[norm! [c]]
--           end)
--         end
--       end
--     end
--   end
-- end
--
-- local function git_next_jump()
--   local view = lib.get_current_view()
--
--   if view and view:instanceof(StandardView.__get()) then
--     local main = view.cur_layout:get_main_win()
--     local curfile = main.file
--
--     if main:is_valid() and curfile:is_valid() then
--       local conflicts, _, cur_idx = git.parse_conflicts(
--         api.nvim_buf_get_lines(curfile.bufnr, 0, -1, false),
--         main.id
--       )
--
--       if #conflicts > 0 then
--         local next_idx = math.min(cur_idx, #conflicts) % #conflicts + 1
--         local next_conflict = conflicts[next_idx]
--         local curwin = api.nvim_get_current_win()
--
--         api.nvim_win_call(main.id, function()
--           api.nvim_win_set_cursor(main.id, { next_conflict.first, 0 })
--           if curwin ~= main.id then view.cur_layout:sync_scroll() end
--         end)
--
--         api.nvim_echo({ { ("Conflict [%d/%d]"):format(next_idx, #conflicts) } }, false, {})
--       else
--         local max = -1
--         local target
--
--         for _, win in ipairs(view.cur_layout.windows) do
--           local c = api.nvim_buf_line_count(api.nvim_win_get_buf(win.id))
--           if c > max then
--             max = c
--             target = win.id
--           end
--         end
--
--         if target then
--           api.nvim_win_call(target, function()
--             vim.cmd [[norm! ]c]]
--           end)
--         end
--       end
--     end
--   end
-- end

diffview.setup({
  diff_binaries = false,
  enhanced_diff_hl = false,
  git_cmd = { "git" },
  use_icons = false,
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    default = {
      layout = "diff2_horizontal",
    },
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
    },
    file_history = {
      layout = "diff2_horizontal",
    },
  },
  file_panel = {
    win_config = {
      position = "left",
      width = 30,
      win_opts = {},
    },
  },
  keymaps = {
    disable_defaults = true,
    view = {
      ["<tab>"] = actions.select_next_entry,
      ["<s-tab>"] = actions.select_prev_entry,
      ["gf"] = actions.goto_file_edit,
      ["<C-w><C-f>"] = actions.goto_file_split,
      ["<C-w>gf"] = actions.goto_file_tab,
      ["<leader>ff"] = actions.focus_files,
      ["<leader>ft"] = actions.toggle_files,
      ["<leader>co"] = actions.conflict_choose("ours"),
      ["<leader>ct"] = actions.conflict_choose("theirs"),
      ["<leader>cb"] = actions.conflict_choose("base"),
      ["<leader>ca"] = actions.conflict_choose("all"),
      ["d1o"] = actions.conflict_choose("all"),
      ["d2o"] = actions.conflict_choose("ours"),
      ["d3o"] = actions.conflict_choose("theirs"),
      ["dx"] = actions.conflict_choose("none"),
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      ["[c"] = "[c",
      ["]c"] = "]c",
      ["[x"] = actions.prev_conflict,
      ["]x"] = actions.next_conflict,
      -- ["[["]         = function() git_prev_jump() end,
      -- ["]]"]         = function() git_next_jump() end,
      ["q"] = actions.close,
    },
    diff1 = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
    },
    diff2 = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
    },
    diff3 = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      { { "n", "x" }, "2do", actions.diffget("ours") },
      { { "n", "x" }, "3do", actions.diffget("theirs") },
    },
    diff4 = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      { { "n", "x" }, "d1o", actions.diffget("all") },
      { { "n", "x" }, "d2o", actions.diffget("ours") },
      { { "n", "x" }, "d3o", actions.diffget("theirs") },
    },
    file_panel = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      ["j"] = actions.select_next_entry,
      ["k"] = actions.select_prev_entry,
      ["<tab>"] = actions.select_next_entry,
      ["<s-tab>"] = actions.select_prev_entry,
      ["<cr>"] = actions.focus_entry,
      ["zR"] = actions.open_all_folds,
      ["zM"] = actions.close_all_folds,
      ["l"] = actions.focus_entry,
      ["o"] = actions.focus_entry,
      ["<2-LeftMouse>"] = actions.select_entry,
      ["-"] = actions.toggle_stage_entry,
      ["S"] = actions.stage_all,
      ["U"] = actions.unstage_all,
      ["X"] = actions.restore_entry,
      ["L"] = actions.open_commit_log,
      ["<c-b>"] = actions.scroll_view(-0.25),
      ["<c-f>"] = actions.scroll_view(0.25),
      ["gf"] = actions.goto_file_edit,
      ["<C-w>gf"] = actions.goto_file_tab,
      ["i"] = actions.listing_style,
      ["f"] = actions.toggle_flatten_dirs,
      ["R"] = actions.refresh_files,
      ["<leader>ff"] = actions.focus_files,
      ["<leader>ft"] = actions.toggle_files,
      ["g<C-x>"] = actions.cycle_layout,
      -- ["N"]             = function() git_prev_jump() end,
      -- ["n"]             = function() git_next_jump() end,
      -- ["[["]            = function() git_prev_jump() end,
      -- ["]]"]            = function() git_next_jump() end,
      ["q"] = "<cmd>DiffviewClose<cr>",
      ["c"] = "<cmd>Git commit<cr>",
      ["p"] = "<cmd>Git! pull<cr>",
      ["P"] = "<cmd>Git! push<cr>",
    },
    file_history_panel = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      ["?"] = actions.options,
      ["<C-A-d>"] = actions.open_in_diffview,
      ["y"] = actions.copy_hash,
      ["L"] = actions.open_commit_log,
      ["zR"] = actions.open_all_folds,
      ["zM"] = actions.close_all_folds,
      ["j"] = actions.next_entry,
      ["<down>"] = actions.next_entry,
      ["k"] = actions.prev_entry,
      ["<up>"] = actions.prev_entry,
      ["<cr>"] = actions.focus_entry,
      ["o"] = actions.focus_entry,
      ["l"] = actions.focus_entry,
      ["<2-LeftMouse>"] = actions.select_entry,
      ["<c-b>"] = actions.scroll_view(-0.25),
      ["<c-f>"] = actions.scroll_view(0.25),
      ["<tab>"] = actions.select_next_entry,
      ["<s-tab>"] = actions.select_prev_entry,
      ["gf"] = actions.goto_file,
      ["<C-w><C-f>"] = actions.goto_file_split,
      ["<C-w>gf"] = actions.goto_file_tab,
      ["<leader>e"] = actions.focus_files,
      ["<leader>b"] = actions.toggle_files,
      ["<leader>ff"] = actions.focus_files,
      ["<leader>ft"] = actions.toggle_files,
      ["g<C-x>"] = actions.cycle_layout,
      ["q"] = actions.close,
    },
    option_panel = {
      ["<leader>gg"] = "<cmd>DiffviewClose<cr>",
      ["<tab>"] = actions.select_entry,
      ["q"] = actions.close,
    },
  },
})
