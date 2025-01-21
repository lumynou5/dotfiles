return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function ()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set({ "n" }, "<Leader>ff", builtin.find_files)
		vim.keymap.set({ "n" }, "<Leader>fg", builtin.live_grep)
		vim.keymap.set({ "n" }, "<Leader>/", builtin.current_buffer_fuzzy_find)
	end,
}
