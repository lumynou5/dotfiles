vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.autoread = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.keymap.set({ "n" }, "J", "<Cmd>move .+1<CR>==")
vim.keymap.set({ "n" }, "K", "<Cmd>move .-2<CR>==")
-- The '< and '> marks are set after leaving visual mode.
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
		-- "--depth=1",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	})
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
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
			require("telescope").setup()
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
				"lua",
				"make",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	{
		"williamboman/mason.nvim",
		version = '^1.8.3',
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "williamboman/mason-lspconfig.nvim", version = "^1.22.0" },
		},
		config = function ()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
				},
				handlers = {
					function (server)
						require("lspconfig")[server].setup({})
					end,
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function (event)
					local opts = { buffer = event.buf }
					vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set({ "n" }, "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n" }, "gr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set({ "n" }, "<Leader>i", vim.lsp.buf.hover, opts)
				end,
			})
		end,
	},
}, {
	install = {
		colorscheme = { "default" },
	},
})
