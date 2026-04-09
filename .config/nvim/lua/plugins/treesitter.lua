return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			require("nvim-treesitter").install({
				"astro",
				"bash",
				"c",
				"cmake",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			})
		end,
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1,
			multiline_threshold = 1,
		},
	},
}
