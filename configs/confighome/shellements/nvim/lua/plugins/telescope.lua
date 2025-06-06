return {
    -- fuzzy finder for files
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
        require("telescope").setup {
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                    no_ignore_parent = true,
                },
            },
            defaults = {
                file_ignore_patterns = {
                    "undodir",
                    "node_modules",
                },
            },
        }
        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        require("custom.telescope.keys")
    end,
}
