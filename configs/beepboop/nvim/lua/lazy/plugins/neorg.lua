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
                        main = "~/Notes",
                        school = "~/Desktop/school",
                    },
                    default_workspace = "main",
                } },
            },
        }
        vim.wo.foldlevel = 99
        -- Global neorg keybinds
        vim.keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "neorg: [n]ew [n]ote" })
        vim.keymap.set("n", "gO", "<cmd>Neorg toc<CR>", { desc = "neorg: Table of Contents" })
        -- .norg file specific keybinds
        vim.api.nvim_create_autocmd("Filetype", {
            pattern = "norg",
            callback = function()
                -- tasks/todo lists
                vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "neorg: Task cycle", buffer = true })
                vim.keymap.set("n", "<leader>ta", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", { desc = "neorg: [t]oggle [a]mbiguous", buffer = true })
                vim.keymap.set("n", "<leader>tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", { desc = "neorg: [t]oggle [c]ancelled", buffer = true })
                vim.keymap.set("n", "<leader>td", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "neorg: [t]oggle [d]one", buffer = true })
                vim.keymap.set("n", "<leader>th", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", { desc = "neorg: [t]oggle on [h]old", buffer = true })
                vim.keymap.set("n", "<leader>ti", "<Plug>(neorg.qol.todo-items.todo.task-important)", { desc = "neorg: [t]oggle [i]mportant", buffer = true })
                vim.keymap.set("n", "<leader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", { desc = "neorg: [t]oggle [p]ending", buffer = true })
                vim.keymap.set("n", "<leader>tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", { desc = "neorg: [t]oggle [r]ecurring", buffer = true })
                vim.keymap.set("n", "<leader>tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { desc = "neorg: [t]oggle [u]ndone", buffer = true })

                -- link hopping
                vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { desc = "neorg: Open link", buffer = true })
                vim.keymap.set("n", "<M-CR>", "<Plug>(neorg.esupports.hop.hop-link.vsplit)", { desc = "neorg: Open link vert split", buffer = true })
                vim.keymap.set("n", "<M-t>", "<Plug>(neorg.esupports.hop.hop-link.tab-drop)", { desc = "neorg: Open link new [t]ab", buffer = true })
                -- inserting date links
                vim.keymap.set("i", "<M-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", { desc = "neorg: insert-[d]ate", buffer = true })
                vim.keymap.set("n", "<leader>id", "<Plug>(neorg.tempus.insert-date)", { desc = "neorg: insert-[d]ate", buffer = true })

                -- heirarchy demotion
                vim.keymap.set("i", "<C-d>", "<Plug>(neorg.promo.demote)", { desc = "neorg: [d]emote single", buffer = true })
                vim.keymap.set("n", "<,", "<Plug>(neorg.promo.demote)", { desc = "neorg: [d]emote single", buffer = true })
                vim.keymap.set("n", "<<", "<Plug>(neorg.promo.demote.nested)", { desc = "neorg: [d]emote nested", buffer = true })
                vim.keymap.set("v", "<", "<Plug>(neorg.promo.demote.range)", { desc = "neorg: [d]emote range", buffer = true })
                -- heirarchy promotion
                vim.keymap.set("i", "<C-t>", "<Plug>(neorg.promo.promote)", { desc = "neorg: [p]romote single", buffer = true })
                vim.keymap.set("n", ">.", "<Plug>(neorg.promo.promote)", { desc = "neorg: [p]romote single", buffer = true })
                vim.keymap.set("n", ">>", "<Plug>(neorg.promo.promote.nested)", { desc = "neorg: [p]romote nested", buffer = true })
                vim.keymap.set("v", ">", "<Plug>(neorg.promo.promote.range)", { desc = "neorg: [p]romote range", buffer = true })

                vim.keymap.set("i", "<M-CR>", "<Plug>(neorg.itero.next-iteration)", { desc = "neorg: Cont. Schema", buffer = true })

                -- open code tag in a temporary buffer
                vim.keymap.set("n", "<leader>mc", "<Plug>(neorg.looking-glass.magnify-code-block)", { desc = "neorg: [m]agnify-[c]ode-block", buffer = true })

                vim.keymap.set("n", "<leader>li", "<Plug>(neorg.pivot.list.invert)", { desc = "neorg: [l]ist [i]nvert", buffer = true })
                vim.keymap.set("n", "<leader>lt", "<Plug>(neorg.pivot.list.toggle)", { desc = "neorg: [l]ist [t]oggle", buffer = true })

                -- custom keybinds
                vim.keymap.set("n", "<leader>tm", function()
                    vim.cmd.Neorg("toggle-concealer")
                end, { desc = "neorg: [t]oggle [m]arkup", buffer = true })
            end,
        })
    end,
}
