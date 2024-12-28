return {
    "nvim-neorg/neorg",
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},  -- Loads the default behaviors
                ["core.concealer"] = {}, -- Makes your notes pretty
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            -- Top level workspace
                            random = "$XDG_DATA_HOME/neorg",

                            -- Main notes workspace
                            notes = "$XDG_DATA_HOME/neorg/notes", -- personal notes

                            -- Extra note workspaces
                            help = "$XDG_DATA_HOME/neorg/help",         -- Helpful/troubleshooting program notes
                            ideas = "$XDG_DATA_HOME/neorg/ideas",       -- My brain children
                            projects = "$XDG_DATA_HOME/neorg/projects", -- Personal projects notes
                            research = "$XDG_DATA_HOME/neorg/research", -- Research notes
                            rum = "$XDG_DATA_HOME/neorg/rum",           -- ruminations, organized chaos?
                            school = "$XDG_DATA_HOME/neorg/school",     -- School notes
                            work = "$XDG_DATA_HOME/neorg/work",         -- Work notes
                        },
                        default_workspace = "random",
                    },
                },
            },
        })
    end,
}
