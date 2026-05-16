local set = vim.opt

set.cmdheight = 1
set.conceallevel = 0
set.ignorecase = true
set.showtabline = 0
set.backspace:append("nostop")
set.clipboard = "unnamedplus"
set.completeopt = { "menu", "menuone", "noselect" }
set.copyindent = true
set.cursorline = true
set.expandtab = true
set.fileencoding = "utf-8"
set.history = 100
set.laststatus = 2
set.mouse = "a"
set.number = true
set.preserveindent = true
set.pumheight = 10
set.relativenumber = true
set.scrolloff = 8
set.shiftwidth = 2
set.sidescrolloff = 8
set.signcolumn = "yes"
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 2
set.termguicolors = true
set.timeoutlen = 300
set.undofile = true
set.updatetime = 300
set.wrap = false
set.linebreak = true
set.breakindent = true
set.writebackup = false
set.showmode = false
set.wildignorecase = true
set.list = true
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldlevel = 99
set.foldlevelstart = 99
set.foldtext = "v:folddashes .. ' ' .. trim(getline(v:foldstart)) .. ' (' .. (v:foldend - v:foldstart + 1) .. ' lines)'"
set.foldenable = true
set.spell = false
set.spelllang = { "en_us" }
set.timeout = false
set.fillchars:append({ diff = "╱", fold = " " })
set.listchars:append({ nbsp = "␣", trail = "." })
set.nrformats:append("alpha")

set.isfname:remove("=")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions-=o",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  command = "setlocal wrap nu",
})

set.diffopt:append("vertical")
