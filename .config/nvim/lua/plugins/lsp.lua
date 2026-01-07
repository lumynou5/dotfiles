return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				height = 0.8,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"astro",
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"ts_ls",
				"yamlls",
			},
			handlers = {
				function (server)
					vim.lsp.config(server, {
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
				["yamlls"] = function ()
					vim.lsp.config("yamlls", {
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
		end,
	},
}
