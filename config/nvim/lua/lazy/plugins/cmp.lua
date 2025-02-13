return {
    -- auto-completions
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
        -- See `:help cmp`
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

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
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
