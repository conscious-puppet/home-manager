local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local themes = require("telescope.themes")
local keymaps = require("general.keymaps.telescope")

keymaps.telescope_picker_mapping()

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local _, telescope_b = pcall(require, "telescope.builtin")
map("n", "<leader>tt", telescope_b.find_files, opts)

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		wrap_results = true,
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.50,
			},
			-- width      = 0.87,
			-- height     = 0.80,
			width = function(_, max_columns, _)
				return max_columns
			end,
			height = function(_, _, max_lines)
				return max_lines
			end,
		},
		mappings = keymaps.telescope_mappings,
		borderchars = (function()
			if vim.g.border_style == "single" then
				return { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
			else
				return { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
			end
		end)(),
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
			mappings = keymaps.telescope_buffer_keymaps,
		},
		git_branches = {
			initial_mode = "normal",
		},
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		--
		["ui-select"] = {
			-- themes.get_dropdown {
			--   -- even more opts
			-- }
			-- themes.get_cursor {
			--   -- even more opts
			-- }
			themes.get_cursor({

				layout_config = {
					height = 9,
					width = 0.7,
				},
			}),
			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
	},

	-- history = {
	--   path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
	--   limit = 100,
	-- },
})

local function load_extension(ext)
	pcall(telescope.load_extension, ext)
end

-- load_extension("smart_history") -- to see old changes
-- load_extension("media_files")
-- load_extension("ui-select")
-- load_extension("file_browser")
-- load_extension("projects")
