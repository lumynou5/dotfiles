return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"c",
			"cmake",
			"json",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"vim",
			"vimdoc",
			"yaml",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
}
