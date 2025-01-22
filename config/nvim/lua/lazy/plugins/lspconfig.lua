return {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- manages LSP, DAP, linters, formatters
        "williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
    },

    config = function()
        local lsp_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        local buf = vim.lsp.buf
        autocmd("LspAttach", {
            desc = "Sets keybindings when a LSP attaches to a buffer",
            group = lsp_group,
            callback = function(e)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func,
                        { buffer = e.buf, desc = "LSP: " .. desc })
                end

                map("gd", function() buf.definition() end, "[G]oto [D]efinition")
                map("<leader>D", function() buf.type_definition() end, "Type [D]efinition")
                map("gD", function() buf.declaration() end, "[G]oto [D]eclaration")
                map("gr", function() buf.references() end, "[G]oto [R]eferences")
                map("gI", function() buf.implementation() end, "[G]oto [I]mplementation")
                map("K", function() buf.hover() end, "Shows Documentation")
                map("<leader>ws", function() buf.workspace_symbol() end, "[W]orkspace [S]ymbols")
                map("<leader>ds", function() buf.document_symbol() end, "[D]ocument [S]ymbols")
                map("<leader>ca", function() buf.code_action() end, "[C]ode [A]ction")
                map("<leader>rn", function() buf.rename() end, "[R]e[n]ame")

                local client = vim.lsp.get_client_by_id(e.data.client_id)
                if client.supports_method('textDocument/formatting') then
                    -- Format the current buffer on save
                    autocmd('BufWritePre', {
                        buffer = e.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = e.buf, id = client.id })
                        end,
                    })
                end
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local lsp_hl_group = vim.api.nvim_create_augroup(
                        'lsp-highlight', { clear = false })
                    autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = e.buf,
                        group = lsp_hl_group,
                        callback = buf.document_highlight,
                    })

                    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = e.buf,
                        group = lsp_hl_group,
                        callback = buf.clear_references,
                    })

                    autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach',
                            { clear = true }),
                        callback = function(event2)
                            buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint
                            .is_enabled { bufnr = e.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- Load server configurations from lsp_server.lua
        local lsp_servers = require("lsp.servers")
        local servers = lsp_servers.servers
        local capabilities = lsp_servers.capabilities

        require("mason").setup()
        require("mason-tool-installer").setup {
            ensure_installed = vim.tbl_keys(servers),
        }
        require("mason-lspconfig").setup({
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
