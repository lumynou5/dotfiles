return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		sources = {
			"filesystem",
			"document_symbols",
		},
		close_if_last_window = true,
		enable_cursor_hijack = true,
		source_selector = {
			sources = {
				{ source = "filesystem" },
				{ source = "document_symbols" },
			},
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				never_show = {
					".git",
				},
			},
		},
	},
	cmd = {
		"Neotree",
	},
	keys = {
		{ "<Leader>t", "<Cmd>Neotree<CR>" }
	},
}
