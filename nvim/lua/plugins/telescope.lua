return {
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	dependencies = { 
		'nvim-lua/plenary.nvim' ,
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{"nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local builtin = require("telescope.builtin")

		local fb_actions = require "telescope".extensions.file_browser.actions

	telescope.setup {
			defaults = {
				path_display={"smart"},
				mappings = {
					n = {
						["q"] = actions.close
					},
				},
			},
			extensions = {
				file_browser = {
					-- disables netrw and use telescope-file-browser in its place
					--theme = "dropdown",
					winblend = 0,
					width = 0.75,
					preview_cutoff = 120,
					results_height = 1,
					results_width = 0.8,
					shorten_path = true,
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["i"] = {
						},
						["n"] = {
							-- your custom normal mode mappings
							["a"] = fb_actions.create,
							["d"] = fb_actions.remove,
							["r"] = fb_actions.rename,
							["y"] = fb_actions.copy,
							["m"] = fb_actions.move,
							["/"] = function()
								vim.cmd('startinsert')
							end
						},
					},
				},
			},
		}
		telescope.load_extension("file_browser")
	end,
}
