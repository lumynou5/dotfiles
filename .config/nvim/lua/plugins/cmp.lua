local kind_icons = {
	Text = "󰀬 ",
	Method = "󰊕 ",
	Function = "󰊕 ",
	Constructor = "󱀥 ",
	Field = "󰓹 ",
	Variable = "󰫧 ",
	Class = "󰙅 ",
	Interface = "󰠱 ",
	Module = "󰏗 ",
	Property = "󰖷 ",
	Unit = "󰑭 ",
	Value = "󰎠 ",
	Enum = "󰈍 ",
	Keyword = "󰦨 ",
	Snippet = "󰯂 ",
	Color = "󰏘 ",
	File = "󰈔 ",
	Reference = "󰌧 ",
	Folder = "󰉋 ",
	EnumMember = "󰫮 ",
	Constant = "󰏿 ",
	Struct = "󰙅 ",
	Event = "󱐋 ",
	Operator = "󰪚 ",
	TypeParameter = "󱄽 ",
}

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function ()
		local cmp = require("cmp")
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function (args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
			},
			mapping = {
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
			},
			formatting = {
				format = function (entry, vim_item)
					vim_item.icon = kind_icons[vim_item.kind]
					vim_item.icon_hl_group = "CmpItemKind" .. vim_item.kind
					return vim_item
				end,
			},
		})
	end,
}
