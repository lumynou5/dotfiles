return {
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		float = {
			max_width = 0.9,
			border = "rounded",
		},
	},
	lazy = false,
	keys = {
		{ "<Leader>t", "<Cmd>Oil --float<CR>" }
	},
}
