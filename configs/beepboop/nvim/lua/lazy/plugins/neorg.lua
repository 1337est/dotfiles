return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*", -- latest stable release
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {

                    },
                },
                ["core.dirman"] = {
                    config = {
                        index = "index.norg",
                        workspaces = {
                            main = "~/Notes",
                        },
                    },
                },
            },
        }
        vim.wo.foldlevel = 99
    end,
}
