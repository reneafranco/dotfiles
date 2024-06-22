-- user/lsp/init.lua

-- Ensure the user directory is in the runtime path
-- vim.cmd('set runtimepath^=~/.config/nvim/lua/user')

-- Load user configurations
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
-- require "user.nvim-tree"
require('nvim-tree').setup{}
require "user.toggleterm"
vim.cmd "colorscheme codemonkey"

-- Ensure LSP config is available
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("LSPConfig not found!")
  return
end

-- Load user-defined LSP handlers
local handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_ok then
  vim.notify("LSP handlers not found!")
  return
end

-- Load Mason and configure language servers
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  vim.notify("Mason not found!")
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  vim.notify("Mason LSPConfig not found!")
  return
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "lua-language-server",
    "pyright",
    "json-lsp",
    "jdtls",
  },
  automatic_installation = true,
})

-- Load null-ls configuration
local null_ls_ok, null_ls = pcall(require, "user.lsp.null-ls")
if not null_ls_ok then
  vim.notify("Null-LS not found!")
  return
end

-- Configure language servers
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.jdtls.setup {
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
}

-- Add more language server configurations as needed

return lspconfig


