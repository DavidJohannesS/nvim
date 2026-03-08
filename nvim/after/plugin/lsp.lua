local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = {"pylsp", "yamlls", "jdtls","lua_ls", "ansiblels", "bashls", "groovyls", "ts_ls" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
end

-- -------------------------
-- Non-Java LSP servers
-- -------------------------

local servers = { "lua_ls", "pylsp", "ansiblels", "bashls" }

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

-- -------------------------
-- JDTLS (Java)
-- -------------------------

-- Load nvim-jdtls only when editing Java files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require("jdtls")

    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root( { ".git"} )
    --local parent = vim.fs.dirname(root_dir) while parent ~= nil do if vim.fn.filereadable(parent .. "/pom.xml") == 1 then root_dir = parent parent = vim.fs.dirname(parent) else break end end

    local home = vim.fn.expand("$HOME")
    local java_home = home .. "/.sdkman/candidates/java/current"
    local lombok_jar = home .. "/lombok.jar"

    local workspace_dir = vim.fn.stdpath("data")
      .. "/site/java/workspace/"
      .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local config_dir = jdtls_path .. "/config_linux"

    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=false",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-javaagent:" .. lombok_jar,
      "-Xbootclasspath/a:" .. lombok_jar,
      "-jar", launcher_jar,
      "-configuration", config_dir,
      "-data", workspace_dir,
    }

    local config = {
      cmd = cmd,
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        java = {
          home = java_home,
          configuration = {
            annotationProcessing = { enabled = true },
            runtimes = {
              { name = "JavaSE", path = java_home },
            },
          },
          format = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          autobuild = { enabled = true },
        },
      },
    }

    jdtls.start_or_attach(config)
  end,
})
