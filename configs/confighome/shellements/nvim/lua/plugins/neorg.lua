return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*", -- latest stable release
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.keybinds"] = { config = {
                    default_keybinds = false,
                } },
                ["core.dirman"] = { config = {
                    index = "index.norg",
                    workspaces = {
                        main = "~/Notes/neorg",
                        school = "~/Desktop/school",
                    },
                    default_workspace = "main",
                } },
            },
        }
        vim.wo.foldlevel = 99
        vim.keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "neorg: [n]ew [n]ote" })
        vim.keymap.set("n", "gO", "<cmd>Neorg toc<CR>", { desc = "neorg: Table of Contents" })

        -- .norg specific keymaps
        require("custom.neorg.cmd")
    end,
}
