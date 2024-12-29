return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- manages LSP, DAP, linters, formatters
        "williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
    },

    config = function()
        local lsp_group = vim.api.nvim_create_augroup("lsp-attach",
            { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("LspAttach", {
            desc = "Sets keybindings when a LSP attaches to a buffer",
            group = lsp_group,
            callback = function(e)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func,
                        { buffer = e.buf, desc = "LSP: " .. desc })
                end

                map("gd", function()
                    vim.lsp.buf.definition()
                end, "[G]oto [D]efinition")

                map("<leader>D", function()
                    vim.lsp.buf.type_definition()
                end, "Type [D]efinition")

                map("gD", function()
                    vim.lsp.buf.declaration()
                end, "[G]oto [D]eclaration")

                map("gr", function()
                    vim.lsp.buf.references()
                end, "[G]oto [R]eferences")

                map("gI", function()
                    vim.lsp.buf.implementation()
                end, "[G]oto [I]mplementation")

                map("K", function()
                    vim.lsp.buf.hover()
                end, "Shows Documentation")

                map("<leader>ws", function()
                    vim.lsp.buf.workspace_symbol()
                end, "[W]orkspace [S]ymbols")

                map("<leader>ds", function()
                    vim.lsp.buf.document_symbol()
                end, "[D]ocument [S]ymbols")

                map("<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, "[C]ode [A]ction")

                map("<leader>rn", function()
                    vim.lsp.buf.rename()
                end, "[R]e[n]ame")

                local client = vim.lsp.get_client_by_id(e.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local lsp_hl_group = vim.api.nvim_create_augroup(
                        'lsp-highlight', { clear = false })
                    autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = e.buf,
                        group = lsp_hl_group,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = e.buf,
                        group = lsp_hl_group,
                        callback = vim.lsp.buf.clear_references,
                    })

                    autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach',
                            { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
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

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities,
            require("cmp_nvim_lsp").default_capabilities())

        local servers = {
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
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            -- NOTE: format config values should be String!
                            defaultConfig = {
                                -- basics
                                indent_style = "space",
                                indent_size = "4",
                                tab_width = "4",
                                quote_style = "none", -- none/single/double
                                continuation_indent = "4",
                                max_line_length = "100",
                                -- align
                                align_function_params = "false",
                                align_continuous_inline_comment = "false",
                                align_array_table = "false",
                                -- line breaks
                                break_all_list_when_line_exceed = "false",
                                auto_collapse_lines = "false",
                                break_before_braces = "false",
                            },
                        },
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
            -- "stylua", -- used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {},
                        capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
