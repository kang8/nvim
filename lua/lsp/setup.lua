local status, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status then
  vim.notify("Not found nvim-lsp-installer")
  return
end

local lsp_installer = require("nvim-lsp-installer")

-- { key: lsp lanuage server name ,value: config file }
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
}

-- Auto install Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)

  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
    local config = servers[server.name]

    if config == nil then
        return
    end

    if config.on_setup then
        config.on_setup(server)
    else
        server:setup({})
    end
end)
