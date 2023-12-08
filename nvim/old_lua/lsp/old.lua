 	local lspconfig = safe_require 'lspconfig'
   	if not lspconfig then
     	return
		end


  require('lsp.handlers').setup()
  require('lsp.handlers').enable_format_on_save()
  require('lsp.null-ls').setup()

  local servers_config = {
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    },
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    },
  }

  local lsp_installer = safe_require 'nvim-lsp-installer'
  if not lsp_installer then
    return
  end

  local servers = { 'eslint', 'tsserver', 'sumneko_lua', 'jsonls' }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      server:install()
    end
  end

  lsp_installer.on_server_ready(function(server)
    local config = servers_config[server.name] or {}
    config.capabilities = require('lsp.handlers').capabilities
    config.on_attach = require('lsp.handlers').on_attach
    server:setup(config)
  end)
