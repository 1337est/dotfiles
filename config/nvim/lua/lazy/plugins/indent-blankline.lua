return {
    -- Adds indentation guides between blocks of code
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    enabled = true,
    config = function()
        require("ibl").setup({
            enabled = true,
            debounce = 200,
            viewport_buffer = {
                min = 30,
                max = 500,
            },
            indent = {
                char = "▎",
                tab_char = nil,
                highlight = "IblIndent",
                smart_indent_cap = true,
                priority = 1,
                repeat_linebreak = true,
            },
            whitespace = {
                highlight = "IblWhitespace",
                remove_blankline_trail = false,
            },
            scope = {
                enabled = true,
                char = nil,
                show_start = false,
                show_end = false,
                show_exact_scope = true,
                injected_languages = true,
                highlight = "IblScope",
                priority = 1024,
                include = {
                    node_type = {},
                },
                exclude = {
                    language = {},
                    node_type = {
                        ["*"] = {
                            "source_file",
                            "program",
                        },
                        lua = {
                            "chunk",
                        },
                        python = {
                            "module",
                        },
                    },
                },
            },
            exclude = {
                filetypes = {
                    "lspinfo",
                    "packer",
                    "checkhealth",
                    "help",
                    "man",
                    "gitcommit",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "",
                },
                buftypes = {
                    "terminal",
                    "nofile",
                    "quickfix",
                    "prompt",
                },
            },
        })
    end,
}
