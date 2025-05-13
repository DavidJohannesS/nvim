
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Automatically install the specified servers
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'ansiblels', 'bashls', 'jdtls' }
})

-- Setup nvim-cmp capabilities with snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Your on_attach function for keybindings
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- Add other keybindings as needed
end

local servers = { 'lua_ls', 'ansiblels', 'bashls', 'jdtls' }
for _, server in ipairs(servers) do
  if server == 'jdtls' then
    -- Custom setup for jdtls
    local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
    local root_dir = lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.getcwd())
    if not root_dir then
      -- Fallback if no root marker is found, adjust as needed
      root_dir = vim.fn.getcwd()
    end
    local workspace_dir =
      vim.fn.stdpath('data') .. '/site/java/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

    local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    local config_dir = jdtls_path .. '/config_linux'

    local lombok_jar = '/home/meow/lombok.jar'
    local java_home = vim.fn.getenv("JAVA_HOME")

    local cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. lombok_jar,
      '-Xbootclasspath/a:' .. lombok_jar,
      '-jar', launcher_jar,
      '-configuration', config_dir,
      '-data', workspace_dir,
    }

    lspconfig.jdtls.setup({
      cmd = vim.tbl_flatten(cmd),
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        java = {
          home = java_home,
          configuration = {
                        annotationProcessing = { enabled = true},
            runtimes = {
              {
                name = "JavaSE-21",
                path = java_home,
              },
            },
            format = { enable = true },
            contentProvider = { preferred = 'fernflower' }, -- Enhances decompiled content readability
            autobuild = { enabled = true }, -- Ensure live updates with LSP
          },
        },
      },
    })
  else
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end
