-- :help options
local set = vim.opt

set.cmdheight      = 1 -- Less space in neovim command line for displaying messages
set.conceallevel   = 0 -- So that `` is visile in markdown files
set.ignorecase     = true -- Ignore case in search patterns
set.showtabline    = 0 -- show tab line
set.backspace      = set.backspace + { "nostop" } -- Don't stop backspace at insert
set.clipboard      = "unnamedplus" -- Connection to the system clipboard
set.completeopt    = { "menu", "menuone", "noselect" } -- Options for insert mode completion
set.copyindent     = true -- Copy the previous indentation on autoindenting
set.cursorline     = true -- Highlight the text line of the cursor
set.expandtab      = true -- Enable the use of space in tab
set.fileencoding   = "utf-8" -- File content encoding for the buffer
set.history        = 100 -- Number of commands to remember in a history table
set.ignorecase     = true -- Case insensitive searching
set.laststatus     = 2
set.lazyredraw     = true -- lazily redraw screen
set.mouse          = "a" -- Enable mouse support
set.number         = true -- Show numberline
set.preserveindent = true -- Preserve indent structure as much as possible
set.pumheight      = 10 -- Height of the pop up menu
set.relativenumber = true -- Show relative numberline
set.scrolloff      = 8 -- Number of lines to keep above and below the cursor
set.shiftwidth     = 2 -- Number of space inserted for indentation
set.sidescrolloff  = 8 -- Number of columns to keep at the sides of the cursor
set.signcolumn     = "yes" -- Always show the sign column
set.smartcase      = true -- Case sensitivie searching
set.splitbelow     = true -- Splitting a new window below the current one
set.splitright     = true -- Splitting a new window at the right of the current one
set.swapfile       = false -- Disable use of swapfile for the buffer
set.tabstop        = 2 -- Number of space in a tab
set.termguicolors  = true -- Enable 24-bit RGB color in the TUI
set.timeoutlen     = 300 -- Length of time to wait for a mapped sequence
set.undofile       = true -- Enable persistent undo
set.updatetime     = 300 -- Length of time to wait before triggering the plugin
set.wrap           = false -- Disable wrapping of lines longer than the width of window
set.writebackup    = false -- Disable making a backup before overwriting a file
set.showmode       = false -- Don't Show --INSERT--
set.wildignorecase = true -- Ignorecase in wildmenu (primarily in command line mode i guess)
set.list           = true -- show tabs and spaces
set.foldmethod     = "syntax" -- auto folds based on exprs
-- set.foldexpr       = "nvim_treesitter#foldexpr()" -- create folds based on treesitter
set.foldlevel      = 99
set.foldlevelstart = 99
set.foldtext       = [[substitute(getline(v:foldstart),'\\\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
set.foldenable     = false
set.spell          = false -- spell check
set.spelllang      = { 'en_us' } -- spell check
-- set.shell          = "/bin/zsh" -- set zsh as shell for integrated terminal
set.timeout        = false -- don't timeout on pressing leader key
set.fillchars      = set.fillchars + 'diff:╱' + 'fold: '
-- set.shortmess      = set.shortmess + "atI" -- I to remove intro screen for now
-- set.guicursor      = "" -- set cursor to block even in insert mode
set.listchars:append("nbsp:␣") -- show tabs and spaces
-- set.listchars:append("eol:↴") -- show tabs and spaces
set.listchars:append("trail:.") -- show tabs and spaces
set.nrformats      = set.nrformats + "alpha" -- I to remove intro screen for now

-- set.iskeyword:append({',', '_', '@', '.', '-'})
vim.cmd [[ set isfname-=: ]]
vim.cmd [[ autocmd FileType * set formatoptions-=o ]]
vim.cmd [[ autocmd User TelescopePreviewerLoaded setlocal wrap nu ]] -- wrap + line number telescope
vim.cmd [[ set diffopt+=vertical ]] -- vertical fugitive diffs

