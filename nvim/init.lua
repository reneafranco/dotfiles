-- user/lsp/init.lua

-- Agrega la carpeta lua/user/ al runtimepath
--vim.cmd('set runtimepath^=~/.config/nvim/lua/user')
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
--require "user.nvim-tree"
require('nvim-tree').setup{}
require "user.toggleterm"
vim.cmd "colorscheme codemonkey"



local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers = require("user.lsp.handlers")

-- Configuración de null-ls
require "user.lsp.null-ls"
require "user.lsp.mason"

-- Configuración de Language Servers
lspconfig.jdtls.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- Agregar más configuración de Language Servers aquí si es necesario

return lspconfig

