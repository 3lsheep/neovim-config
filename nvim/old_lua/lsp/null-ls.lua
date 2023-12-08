local M = {}

M.setup = function()
	local null_ls = safe_require 'null-ls'
	if not null_ls then
		return
	end

	local format = null_ls.builtins.formatting
	local diagnostic = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions

	null_ls.setup {
		sources = {
			---diagnostic.eslint,
			--format.prettierd.with({
			--    env = {
			--       PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.config/nvim/.prettierrc",
			--    }
			--}),
			-- code_actions.eslint
			format.prettier,
			--- format.stylua,
		},
		on_attach = function(client, bufnr)
			local ok, lsp_format = pcall(require, "lsp-format")
			if ok then
				lsp_format.on_attach(client)
			end
		end,
	}
end

return M
