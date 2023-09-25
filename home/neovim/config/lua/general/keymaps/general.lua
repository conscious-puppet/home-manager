local opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


map("n", "//", "<CMD>noh<CR>", opts)

map("n", "gf", "gF", opts)

-- map("n", "<C-q>", ":bd<CR>", opts) -- close current buffer
-- map("n", "<C-w>m", "<CMD>tabedit % | norm <C-o><CR>", opts) -- replicate current buffer into new tab
map("n", "<C-w>m", "<CMD>tab split<CR>", opts) -- replicate current buffer into new tab

map("n", "]q", "<CMD>cnext<CR>", opts)
map("n", "[q", "<CMD>cprev<CR>", opts)

map("n", "]l", "<CMD>lnext<CR>", opts)
map("n", "[l", "<CMD>lprev<CR>", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)


-- File Related
map("n", "<leader>ft", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>ff", "<cmd>NvimTreeFocus<cr>", opts)

-- map("n", "<leader>g", "<cmd>LazyGit<cr>", opts)
-- map("n", "<leader>g", "<cmd>tab G<cr>", opts)
-- map("n", "<leader>gg", "<cmd>DiffviewOpen<cr>", opts)
map("n", "<leader>gg", "<cmd>tab G<cr>", opts)
map("n", "<leader>gb", "<cmd>MerginalToggle<cr>", opts)
map("n", "<leader>gB", "<cmd>G blame<cr>", opts)

-- lsp lines
-- local lsp_lines_status_ok, lsp_lines = pcall(require, "lsp_lines")
-- if lsp_lines_status_ok then
--   map("n", "gl", lsp_lines.toggle, opts)
-- end

-- Trouble
local trouble_status_ok, _ = pcall(require, "trouble")
if trouble_status_ok then
  map("n", "<leader>d", "<cmd>Trouble document_diagnostics<cr>", { noremap = true })
  map("n", "<leader>D", "<cmd>Trouble workspace_diagnostics<cr>", { noremap = true })
end


local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_status_ok then
  -- map("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", { noremap = true })
  -- map("n", "]c", "<cmd>Gitsigns next_hunk<cr>", { noremap = true })
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gitsigns.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, noremap = true })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gitsigns.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, noremap = true })
end

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Comment
-- map("n", "<leader>/", function() require("Comment.api").toggle_current_linewise() end, opts)
-- map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", opts)

-- Ctrl hjkl in command line mode, not needed as nvim-cmp as auto trigger
map("c", "<C-j>", "<C-n>", { noremap = true })
map("c", "<C-k>", "<C-p>", { noremap = true })
map("c", "<C-h>", "<Up>", { noremap = true })
map("c", "<C-l>", "<Down>", { noremap = true })

-- Improved Terminal Mappings
map("t", "<esc>", "<C-\\><C-n>")
-- map("t", "<C-h>", "<c-\\><c-n><c-w>h")
-- map("t", "<C-j>", "<c-\\><c-n><c-w>j")
-- map("t", "<C-k>", "<c-\\><c-n><c-w>k")
-- map("t", "<C-l>", "<c-\\><c-n><c-w>l")

