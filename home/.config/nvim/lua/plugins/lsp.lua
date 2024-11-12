return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", version = "^1.8.3", config = true },
		{ "williamboman/mason-lspconfig.nvim", version = "^1.22.0" },
	},
	config = function ()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"astro",
				"clangd",
				"cmake",
				"lua_ls",
				"pylyzer",
				"rust_analyzer",
				"ts_ls",
				"yamlls",
			},
			handlers = {
				function (server)
					require("lspconfig")[server].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
				["yamlls"] = function ()
					require("lspconfig").yamlls.setup({
						settings = {
							yaml = {
								schemaStore = {
									enable = true,
									url = "https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json",
								},
							},
						},
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
}
