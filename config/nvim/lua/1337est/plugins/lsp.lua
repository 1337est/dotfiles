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
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
    },

    config = function()
        -- Making the keymaps
        local lsp_group = vim.api.nvim_create_augroup("lsp-attach",
            { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        --  This function gets run when an LSP attaches to a particular buffer.
        --  That is to say, every time a new file is opened that is associated with
        --  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --  function will be executed to configure the current buffer
        autocmd("LspAttach", {
            desc = "Sets keybindings when a LSP attaches to a buffer",
            group = lsp_group,
            callback = function(e)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func,
                        { buffer = e.buf, desc = "LSP: " .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map("gd", function()
                    vim.lsp.buf.definition()
                end, "[G]oto [D]efinition")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", function()
                    vim.lsp.buf.type_definition()
                end, "Type [D]efinition")

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map("gD", function()
                    vim.lsp.buf.declaration()
                end, "[G]oto [D]eclaration")

                -- Find references for the word under your cursor.
                map("gr", function()
                    vim.lsp.buf.references()
                end, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", function()
                    vim.lsp.buf.implementation()
                end, "[G]oto [I]mplementation")


                map("K", function()
                    vim.lsp.buf.hover()
                end, "Shows Documentation")

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", function()
                    vim.lsp.buf.workspace_symbol()
                end, "[W]orkspace [S]ymbols")

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map("<leader>ds", function()
                    vim.lsp.buf.document_symbol()
                end, "[D]ocument [S]ymbols")

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map("<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, "[C]ode [A]ction")

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map("<leader>rn", function()
                    vim.lsp.buf.rename()
                end, "[R]e[n]ame")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
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
                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
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
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                -- capabilities = {},
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            -- Put format options here
                            -- NOTE: the value should be String!
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

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua", -- used to format Lua code
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
