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
    sqlls = {},
    glsl_analyzer = {},
    hyprls = {},
    lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        settings = {
            Lua = {
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
                    disable = { "missing-fields" },
                    globals = { "vim" },
                },
            },
        },
    },
}

return { servers = servers, capabilities = capabilities }
