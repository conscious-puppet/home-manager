vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "haskell" },
  callback = function()
    vim.opt_local.iskeyword:append("'")

    local map = vim.keymap.set

    -- local preserve = function(arguments)
    --   -- local arguments = string.format("keepjumps keeppatterns execute %q", arguments)
    --   -- local original_cursor = vim.fn.winsaveview()
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   vim.api.nvim_command(arguments)
    --   local lastline = vim.fn.line("$")
    --   -- vim.fn.winrestview(original_cursor)
    --   if line > lastline then
    --     line = lastline
    --   end
    --   vim.api.nvim_win_set_cursor({ 0 }, { line, col })
    -- end
    --
    -- map("n", "Q", function()
    --   preserve("%!hindent")
    -- end, { buffer = true, noremap = true })
    -- map({ "v", "x" }, "Q", function()
    --   preserve("<esc>'<,'>!hindent")
    -- end
    --   , { buffer = true, noremap = true })

    local hindent_dirs = { "work" }
    for _, dir in ipairs(hindent_dirs) do
      if string.find(vim.api.nvim_buf_get_name(0), dir) then
        local disable_formatting = vim.g.disable_formatting
        disable_formatting.hls = true
        vim.g.disable_formatting = disable_formatting
        vim.cmd [[setlocal formatprg=hindent]]
        map("n", "Q", "<cmd>%!hindent<CR>", { buffer = true, noremap = true })
        map({ "v", "x" }, "Q", "<esc><cmd>'<,'>!hindent<cr>", { buffer = true, noremap = true })
      else
        local disable_formatting = vim.g.disable_formatting
        disable_formatting.hls = false
        vim.g.disable_formatting = disable_formatting
      end
    end

    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      cmp.setup.filetype('haskell', {
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            option = {
              keyword_pattern = [[\k\+]],
            }
          },
          {
            name = "buffer",
            option = {
              keyword_pattern = [[\k\+]],
            }
          },
          { name = "path" },
        })
      })
    end
  end,
})
