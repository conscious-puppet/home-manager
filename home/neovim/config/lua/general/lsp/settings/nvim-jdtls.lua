local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local on_attach = require("abshekh.lsp.handlers").on_attach
local capabilities = require("abshekh.lsp.handlers").capabilities

-- (after! java-mode
--   (setq lsp-java-format-settings-url "http://google.github.io/styleguide/eclipse-java-google-style.xml")
--   (setq lsp-java-format-settings-profile "GoogleStyle"))


-- Determine OS
local home = os.getenv("HOME")

WORKSPACE_PATH = home .. "/.cache/jdtls-workspace/"

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
-- extendedClientCapabilities.progressReportProvider = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  cmd = {"jdt-language-server", "-data", workspace_dir},
  capabilities = capabilities,
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
  -- for a list of options
  settings = {
    java = {
      -- jdt = {
      --   ls = {
      --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx4G -Xms100m"
      --   }
      -- },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = false,
      },
      referencesCodeLens = {
        enabled = false,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        -- enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle"
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      enabled = true,
      -- overwrite = true,
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
    -- bundles = bundles,
  },
  handlers = {
    ['language/status'] = function() end,         -- disable language status in command line
    -- ['language/progressReport'] = function() end, -- disable language status in command line
    -- ["$/progress"] = function() end,              -- disable language status in command line
  },
}

config["on_attach"] = function(client, bufnr)
  -- local _, _ = pcall(vim.lsp.codelens.refresh)
  -- require("jdtls.dap").setup_dap_main_class_configs()
  -- jdtls.setup_dap({ hotcodereplace = "auto" })
  on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    -- if desc then
    --   desc = desc
    -- end

    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
  end
  map("n", "<leader>Co", jdtls.organize_imports, "Organize Imports")
  map("n", "<leader>Cv", jdtls.extract_variable, "Extract Variable")
  map("n", "<leader>Cc", jdtls.extract_constant, "Extract Constant")
  map("n", "<leader>Ct", jdtls.test_nearest_method, "Test Method")
  map("n", "<leader>CT", jdtls.test_class, "Test Class")
  map("n", "<leader>Cu", "<Cmd>JdtUpdateConfig<CR>", "Update Config")
  map("v", "<leader>Cv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable")
  map("v", "<leader>Cc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant")
  map("v", "<leader>Cm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method")
end

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "*.java" },
--   callback = function()
--     local _, _ = pcall(vim.lsp.codelens.refresh)
--   end,
-- })

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
-- jdtls.start_or_attach(config)

-- vim.cmd(
--   [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
-- )
-- vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
-- vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- -- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
-- vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- -- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

return config

