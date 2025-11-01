local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "ansiblels", "bashls", "jdtls", "groovyls", "ts_ls" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
end

local servers = { "lua_ls", "ansiblels", "bashls", "jdtls" }

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == "jdtls" then
    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = vim.fs.find(root_markers, { upward = true })[1] or vim.fn.getcwd()

    local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local config_dir = jdtls_path .. "/config_linux"

    local java_home = vim.fn.expand("$HOME/.sdkman/candidates/java/current")
    local lombok_jar = vim.fn.expand("$HOME/lombok.jar")

    opts.cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
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

    opts.root_dir = root_dir
    opts.settings = {
      java = {
        home = java_home,
        configuration = {
          annotationProcessing = { enabled = true },
          runtimes = {
            { name = "JavaSE-21", path = java_home },
          },
          format = { enable = true },
          contentProvider = { preferred = "fernflower" },
          autobuild = { enabled = true },
        },
      },
    }
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
