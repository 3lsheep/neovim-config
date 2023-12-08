return {
	"rshkarin/mason-nvim-lint",
	priority = 97,
	config = function()
		require("mason-nvim-lint").setup({
			ensure_installed = { "eslint_d" },
		})
	end,
}
