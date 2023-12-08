local cmp = safe_require 'cmp'
  local lspkind = safe_require 'lspkind'
  if not cmp or not lspkind then
    return
  end

  vim.opt.completeopt = 'menu,menuone,noselect'

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text', -- show only symbol annotations
        preset = 'codicons', -- https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      },
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    -- Sources order are actually their priority order
    sources = cmp.config.sources {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'emoji' },
    },
    mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
  }
