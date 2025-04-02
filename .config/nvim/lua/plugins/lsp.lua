return {
	{
		"williamboman/mason.nvim",
		version = "^1.8.3",
		opts = {
			ui = {
				border = "rounded",
				height = 0.8,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.22.0",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"astro",
				"bashls",
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
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function ()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function (event)
					local opts = { buffer = event.buf }
					vim.keymap.set({ "n" }, "grD", vim.lsp.buf.declaration, opts)
					vim.keymap.set({ "n" }, "grd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n" }, "grr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set({ "n" }, "grh", vim.lsp.buf.hover, opts)
					vim.keymap.set({ "n" }, "gre", vim.diagnostic.open_float, opts)
				end,
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		end,
	},
}
