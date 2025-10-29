return {
	"lewis6991/gitsigns.nvim",
	config = true,
	event = "BufEnter",
	keys = {
		{ "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>", mode = "n" },
		{ "<Leader>hu", "<Cmd>Gitsigns undo_stage_hunk<CR>", mode = "n" },
		{ "<Leader>hr", "<Cmd>Gitsigns reset_hunk<CR>", mode = "n" },
		{ "<Leader>hd", "<Cmd>Gitsigns diffthis<CR>", mode = "n" },
		{ "<Leader>hb", "<Cmd>Gitsigns blame<CR>", mode = "n" },
	},
}
