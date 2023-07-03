local status_ok, lsp_installer= pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end


local servers = {
  "gopls",
  "jsonls",
  "vimls",
  "clangd",
  "pyright",
  "rust_analyzer"
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end


local opts = {}

for _, name in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end
  -- 自动安装 LanguageServers
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end

  lspconfig[name].setup(opts)
end

require'lspconfig'.crystalline.setup{filetypes = {"thrift"}}
