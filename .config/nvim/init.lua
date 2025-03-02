vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.colorcolumn = "+1"
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.splitright = true
vim.opt.scrolloff = 5
vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.keymap.set({ "n" }, "<C-j>", "<Cmd>move .+1<CR>==")
vim.keymap.set({ "n" }, "<C-k>", "<Cmd>move .-2<CR>==")
-- The '< and '> marks are set after leaving visual mode, and <Cmd> doesn't
-- leave the mode.
vim.keymap.set({ "v" }, "<C-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set({ "v" }, "<C-k>", ":move '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")

vim.keymap.set({ "n" }, "<Leader>bc", "<Cmd>bdelete<CR>")

-- Bootstrap Lazy.nvim.
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	}):wait()
end
vim.opt.runtimepath:prepend(lazy_path)

require("lazy").setup("plugins", {
	install = {
		colorscheme = { "catppuccin-mocha" },
	},
	ui = {
		border = "rounded",
	},
})

vim.cmd("colorscheme catppuccin-mocha")
