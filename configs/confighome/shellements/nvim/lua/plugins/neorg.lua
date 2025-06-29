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
                        main = "~/Desktop/notes/",
                        neorg = "~/Desktop/notes/neorg",
                        school = "~/Desktop/notes/school",
                        work = "~/Desktop/notes/work",
                    },
                    default_workspace = "main",
                } },
                ["core.journal"] = { config = {
                    journal_folder = "journal",      -- name of the journal folder
                    strategy = "nested",             -- "flat" = 2022-03-02.norg, nested = 2022/03/02.norg
                    template_name = "template.norg", -- name of the template file to use
                    use_template = true,             -- Whether to use the template file for new entries
                    workspace = "neorg",             -- default workspace for journal
                } },
                ["core.autocommands"] = {},
                ["core.highlights"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.export"] = {},          -- Enables exporting
                ["core.export.markdown"] = {}, -- Export to markdown
            },
        }
        vim.wo.foldlevel = 99
        vim.keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "neorg: [n]ew [n]ote" })
        vim.keymap.set("n", "gO", "<cmd>Neorg toc<CR>", { desc = "neorg: Table of Contents" })

        -- .norg specific keymaps
        require("custom.neorg.cmd")
    end,
}
