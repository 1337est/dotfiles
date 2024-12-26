return {
	--[[
    Collection of community-contributed configurations for the built-in
	lanuage server client in Nvim core. This plugin provides four
	primary functionalities:

	    - default launch commands, initialization options, and settings for each
	    server
	    - a root directory resolver which attempts to detect the root of your project
	    - an autocommand mapping that either launches a new language server or
	    attempts to attach a language server to each opened buffer if it falls
	    under a tracked project - utility commands such as LspInfo, LspStart, LspStop, and LspRestart for managing language server instances --]]

	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		{ "williamboman/mason.nvim", config = true }, -- manages LSP, DAP, linters, formatters
		"williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
		"hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim", -- LSP status updates lower right
	},

	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local servers = {
			-- $XDG-CONFIG-HOME/clangd/config.yaml with CompileFlags: Add: [-I/path/to/dev/libs]
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			ts_ls = {},
			bashls = {},
			html = {},
			cssls = {},
			cmake = {},
			sqlls = {},
			glslls = {},
			glsl_analyzer = {},

			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim" },
						},
					},
				},
			},
		}
		local ensure_installed = vim.tbl_keys(servers or {})

		require("mason").setup()
		vim.list_extend(ensure_installed, {
			"stylua", -- used to format Lua code
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		require("conform").setup({
			formatters_by_ft = {},
		})
		require("fidget").setup({})
	end,
}
