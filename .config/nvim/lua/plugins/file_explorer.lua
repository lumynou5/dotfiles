return {
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		float = {
			max_width = 0.8,
			max_height = 0.8,
		},
	},
	lazy = false,
	keys = {
		{ "<Leader>t", "<Cmd>Oil --float<CR>" }
	},
}
