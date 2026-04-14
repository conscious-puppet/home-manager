local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Leader key must be set BEFORE any keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map Space to nothing in normal mode (prevent default behavior)
map("n", "<Space>", "<Nop>", opts)

-- Search clearing
map("n", "//", "<CMD>noh<CR>", opts)

-- File navigation
map("n", "gf", "gF", opts)

-- Tab operations
map("n", "<C-w>m", "<CMD>tab split<CR>", opts)

-- Quickfix navigation
map("n", "]q", "<CMD>cnext<CR>", opts)
map("n", "[q", "<CMD>cprev<CR>", opts)

-- Location list navigation
map("n", "]l", "<CMD>lnext<CR>", opts)
map("n", "[l", "<CMD>lprev<CR>", opts)

-- Window resizing
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual mode indentation (stay in indent mode)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Visual mode line movement
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Command line navigation
map("c", "<C-j>", "<C-n>", { noremap = true })
map("c", "<C-k>", "<C-p>", { noremap = true })
map("c", "<C-h>", "<Up>", { noremap = true })
map("c", "<C-l>", "<Down>", { noremap = true })

-- Terminal escape
map("t", "<esc>", "<C-\\><C-n>")
