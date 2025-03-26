return {
    {
        "navarasu/onedark.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            require("onedark").setup {
                style = "cool",
                transparent = true,
                ending_tildes = true,
            }
            require('onedark').load()
            vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
            vim.api.nvim_set_hl(0, "@markup.underline", { underline = true })
            vim.api.nvim_set_hl(0, "@text.strong", { bold = true })
            vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- The documentation on this kinda sucks
            require("colorizer").setup(
            -- 1st table: list of filetypes
            -- 2nd table: list of default options from the plugin page
                { '*' }, -- all filetypes
                {
                    RGB      = true, -- #FF0 hex codes
                    RRGGBB   = true, -- #FF0000 hex codes
                    names    = false, -- "Name" codes like Blue
                    RRGGBBAA = false, -- #RRGGBBAA hex codes
                    rgb_fn   = false, -- CSS rgb() and rgba() functions
                    hsl_fn   = false, -- CSS hsl() and hsla() functions
                    css      = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn   = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes: foreground, background
                    mode     = 'background', -- Set the display mode.
                }
            )
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                },
                signs_staged = {
                    add = { text = "+" },
                    change = { text = "~" },
                },
            }
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup {
                exclude = { filetypes = {
                    "lspinfo",
                    "packer",
                    "checkhealth",
                    "help",
                    "man",
                    "gitcommit",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "",
                    "dashboard",
                } }
            }
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
            require("lualine").setup {
                options = {
                    theme = "onedark",
                    disabled_filetypes = {
                        statusline = { 'NvimTree' },
                        winbar = { 'NvimTree' },
                    },
                },
                sections = {
                    lualine_a = { { "mode" } },
                    lualine_b = { { "diagnostics", symbols = symbols } },
                    lualine_c = { { "filename", path = 4 } },
                    lualine_x = { {
                        "filetype",
                        icon = { align = 'left' }
                    } },
                    lualine_y = {
                        {
                            "branch",
                            color = { fg = '#f2cc81', bg = nil }
                        },
                        { "diff" },
                    },
                    lualine_z = { "location", "progress" },
                },
                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_z = { "location", "progress" },
                },
            }
        end,
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        opts = {},
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    {
        "folke/todo-comments.nvim",
        enabled = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            colors = {
                error = { "#f65866" }, -- red
                warning = { "#efbd5d" }, -- yellow
                info = { "#41a7fc" }, -- blue
                hint = { "#c75ae8" }, -- purple
                default = { "#8bcd5b" }, -- green
                test = { "#34bfd0" }, -- cyan
            },
        }
    },

    {
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
            spec = {
                { "<leader>c", group = "[c]ode", mode = { "n", "x" } },
                { "<leader>d", group = "[d]ocument", mode = "n" },
                { "<leader>r", group = "[r]ename", mode = "n" },
                { "<leader>s", group = "[s]earch", mode = "n" },
                { "<leader>t", group = "[t]oggle", mode = "n" },
                { "<leader>w", group = "[w]orkspace", mode = "n" },
                { "<leader>k", group = "[k]eep", mode = { "n", "v" } },
                { "<leader>", group = "Leader", mode = { "n", "v" } },
                { "[", group = "Previous", mode = "n" },
                { "]", group = "Next", mode = "n" },
            }
        }
    },
}
