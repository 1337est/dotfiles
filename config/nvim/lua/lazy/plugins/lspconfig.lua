return {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- manages LSP, DAP, linters, formatters
        "williamboman/mason-lspconfig.nvim", -- integrates mason & lspconfig
        "hrsh7th/cmp-nvim-lsp-signature-help", -- display func-param signatures
        "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
        "hrsh7th/cmp-buffer", -- completions for words in different buffers
        "hrsh7th/cmp-path", -- completions for filesystem paths
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip", -- snippet engine written in Lua
        "saadparwaiz1/cmp_luasnip", -- completions for LuaSnip
        "j-hui/fidget.nvim",
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

        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "gopls",
                "rust_analyzer",
                "hyprls",
                "lua_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                format = {
                                    enable = true,
                                    defaultConfig = {
                                        indent_style = "space",
                                        indent_size = "4",
                                        tab_width = "4",
                                        quote_style = "none",
                                        continuation_indent = "4",
                                        max_line_length = "100",
                                        align_function_params = "false",
                                        align_continuous_inline_comment = "false",
                                        align_array_table = "false",
                                        break_all_list_when_line_exceed = "false",
                                        auto_collapse_lines = "false",
                                        break_before_braces = "false",
                                    },
                                },
                                completion = { callSnippet = "Replace" },
                                diagnostics = {
                                    disable = { "mising-fiels" },
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "path" },
                { name = "buffer" },
                { name = "nvim_lsp_signature_help" },
            })
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
    end
}
