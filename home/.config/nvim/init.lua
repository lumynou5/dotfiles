vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.splitright = true
vim.opt.scrolloff = 5
vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.keymap.set({ "n" }, "J", "<Cmd>move .+1<CR>==")
vim.keymap.set({ "n" }, "K", "<Cmd>move .-2<CR>==")
-- The '< and '> marks are set after leaving visual mode, and <Cmd> doesn't
-- leave the mode.
vim.keymap.set({ "v" }, "J", ":move '>+1<CR>gv=gv")
vim.keymap.set({ "v" }, "K", ":move '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")

vim.keymap.set({ "n" }, "<Leader>bc", "<Cmd>bdelete<CR>")

-- Bootstrap Lazy.nvim.
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	})
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			styles = {
				conditionals = {},
			},
		},
	},
	{
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
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
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
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
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
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", version = "^1.8.3" },
			{ "williamboman/mason-lspconfig.nvim", version = "^1.22.0" },
			{ "folke/neodev.nvim", version = "^2.5.2" },
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
		config = function ()
			require("neodev").setup()
			require("fidget").setup()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"cmake",
					"lua_ls",
					"pylyzer",
					"rust_analyzer",
				},
				handlers = {
					function (server)
						require("lspconfig")[server].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function (event)
					local opts = { buffer = event.buf }
					vim.keymap.set({ "n" }, "<Leader>lD", vim.lsp.buf.declaration, opts)
					vim.keymap.set({ "n" }, "<Leader>ld", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n" }, "<Leader>lr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set({ "n" }, "<Leader>lh", vim.lsp.buf.hover, opts)
					vim.keymap.set({ "n" }, "<Leader>le", vim.diagnostic.open_float, opts)
					vim.keymap.set({ "n" }, "<Leader>lm", vim.lsp.buf.rename, opts)
				end,
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		end,
	},
	{
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
					["<Tab>"] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i" }),
					["<S-Tab>"] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i" }),
					["<Esc>"] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.abort()
						end
						-- Exit insert mode anyway.
						fallback()
					end, { "i" }),
					["<CR>"] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.confirm()
						else
							fallback()
						end
					end, { "i" }),
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "^2.1.0",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		build = "make install_jsregexp",
		config = function ()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
})
vim.cmd("colorscheme catppuccin-mocha")
