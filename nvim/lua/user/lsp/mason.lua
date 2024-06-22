local servers = {
  "lua_ls",
  "pyright",
  "jsonls",
  "jdtls"
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  if server == "jdtls" then
    -- Configuración específica para jdtls
    local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")
    local root_markers = { 'gradlew', '.git', 'mvnw' }
    local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])

    opts.cmd = { jdtls_path }
    opts.root_dir = root_dir
    opts.settings = {
      java = {}
    }
    opts.init_options = {
      bundles = {}
    }

    require('jdtls').start_or_attach(opts)
  else
    lspconfig[server].setup(opts)
  end
end

