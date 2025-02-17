return {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
        { "williamboman/mason.nvim", opts = {} }, -- manages LSP, DAP, linters, formatters
        "williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
        { 'j-hui/fidget.nvim', opts = {} },
        "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
    },

    config = function()
        require("lazy.plugins.custom.lsp.cmd")

        local lsp_servers = require("lazy.plugins.custom.lsp.servers")
        local servers = lsp_servers.servers
        local capabilities = lsp_servers.capabilities

        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                        server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
