return {
    "nvim-neorg/neorg",
    enabled = true,
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {

                ["core.defaults"] = { -- Loads the default behaviors
                    config = {
                        -- This module only contains the "disable" configuration options
                        -- Uncomment to disable a module
                        disable = {
                            -- "core.defaults",
                            -- "core.autocommands",
                            -- "core.clipboard",
                            -- "core.clipboard.code-blocks",
                            -- "core.esupports.hop",
                            -- "core.esupports.indent",
                            -- "core.esupports.metagen",
                            -- "core.integrations.treesitter",
                            -- "core.itero",
                            -- "core.journal",
                            -- "core.keybinds",
                            -- "core.looking-glass",
                            -- "core.neorgcmd",
                            -- "core.pivot",
                            -- "core.promo",
                            -- "core.qol.toc",
                            -- "core.qol.todo_items",
                            -- "core.storage",
                            -- "core.tangle",
                            -- "core.tempus",
                            -- "core.todo-introspector",
                            -- "core.ui.calendar",
                        },
                    },
                },

                ["core.concealer"] = { -- Makes your notes pretty
                    config = {
                        folds = true,
                        icon_preset = "basic",
                        icons = {
                            code_block = {
                                conceal = false,
                                content_only = true,
                                insert_enabled = true,
                                padding = { left = 0, right = 0 },
                                spell_check = true,
                                width = "fullwidth",
                            },
                            definition = {
                                multi_prefix = { icon = "⋙ " },
                                multi_suffix = { icon = "⋘ " },
                                single = { icon = "≡" },
                            },
                            delimiter = {
                                horizontal_line = { icon = "─", left = "here", right = "window" },
                                strong = { icon = "⟪" },
                                weak = { icon = "⟨" },
                            },
                            footnote = {
                                multi_prefix = { icon = "⁑ " },
                                multi_suffix = { icon = "⁑ " },
                                single = { icon = "⁎", numeric_superscript = true },
                            },
                            heading = {
                                icons = { "◉", "◎", "○", "✺", "▶", "⤷" },
                            },
                            list = {
                                icons = "•",
                            },
                            markup = {
                                spoiler = { icon = "•" },
                            },
                            ordered = {
                                icons = { "1.", "A.", "a.", "(1)", "I.", "i." },
                            },
                            quote = {
                                icons = "│",
                            },
                            todo = {
                                cancelled = { icon = "" },
                                done = { icon = "󰄬" },
                                on_hold = { icon = "" },
                                pending = { icon = "󰥔" },
                                recurring = { icon = "↺" },
                                uncertain = { icon = "" },
                                undone = { icon = "×" },
                                urgent = { icon = "⚠" },
                            },
                        },
                        init_open_folds = "auto",
                    },
                },

                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        -- My desktop is my messy workspace filled with notes, like in real life
                        workspaces = {
                            -- Local notes workspaces --
                            -- Top level notes workspace (not a git repo -- random)
                            desktop = os.getenv("XDG_DESKTOP_DIR"), -- ~/Desktop
                            school = os.getenv("LEET_SCHOOL_DIR"), -- School notes ~/Desktop/school
                            work = os.getenv("LEET_WORK_DIR"), -- Work notes ~/Desktop/work
                            projects = os.getenv("LEET_PROJECTS_DIR"), -- Personal projects notes ~/Code/projects
                            research = os.getenv("LEET_RESEARCH_DIR"), -- Research notes ~/Code/research

                            -- Main notes workspace (git repo)
                            neorg = os.getenv("XDG_DESKTOP_DIR") .. "/neorg", -- personal notes
                            -- Extra note workspaces
                            help = os.getenv("XDG_DESKTOP_DIR") .. "/neorg/help", -- Helpful/troubleshooting program notes
                            ideas = os.getenv("XDG_DESKTOP_DIR") .. "/neorg/ideas", -- My brain children
                            rum = os.getenv("XDG_DESKTOP_DIR") .. "/neorg/rum", -- ruminations, organized chaos?
                        },
                        index = "index.norg", -- The name of the main (root) .norg file
                        default_workspace = "desktop",
                        open_last_workspace = false,
                        use_popup = true,
                    },
                },
            },
        })
    end,
}
