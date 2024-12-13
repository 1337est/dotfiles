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
		{ "williamboman/mason.nvim", config = true }, -- manages LSP, DAP, linters, formatters
		"williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Installs/upgrades mason's 3rd-party tools
		"hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
		{ "j-hui/fidget.nvim", opts = {} }, -- LSP status updates lower right
	},

	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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

		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
