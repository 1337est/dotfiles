return {
    {
        "windwp/nvim-autopairs",
        enabled = true,
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                disable_in_macro = true, -- disable when recording or executing a macro
                disable_in_visualblock = false, -- disable when insert after visual block mode
                disable_in_replace_mode = true,
                ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
                enable_moveright = true,
                enable_afterquote = true, -- add bracket pairs after quote
                enable_check_bracket_line = true, --- check bracket in same line
                enable_bracket_in_quote = true, --
                enable_abbr = false, -- trigger abbreviation
                break_undo = true, -- switch for basic rule break undo sequence
                check_ts = false,
                map_cr = true,
                map_bs = true, -- map the <BS> key
                map_c_h = false, -- Map the <C-h> key to delete a pair
                map_c_w = false, -- map <c-w> to delete a pair if possible
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip", -- snippet engine written in Lua
            "saadparwaiz1/cmp_luasnip", -- completions for LuaSnip
            "hrsh7th/cmp-buffer", -- completions for words in different buffers
            "hrsh7th/cmp-nvim-lsp", -- adds more completions for LSP's
            "hrsh7th/cmp-path", -- completions for filesystem paths
            "hrsh7th/cmp-nvim-lsp-signature-help", -- display func-param signatures
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },

                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    ["<C-Space>"] = cmp.mapping.complete({}),

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

                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                },
            })
        end,
    }
}
