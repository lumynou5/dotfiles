return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = " ", right = " " },
			disabled_filetypes = { statusline = { "alpha" } },
		},
		sections = {
			lualine_a = { { "mode" } },
			lualine_b = { { "branch", icon = "󰘬" } },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { { "diagnostics" } },
			lualine_y = {
				{ "filetype" },
				{ "encoding" },
			},
			lualine_z = {
				{ "progress" },
				{ "location" },
			},
		},
	},
}
