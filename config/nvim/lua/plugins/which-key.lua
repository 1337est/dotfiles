return {
    -- Popup menu for keymaps
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup({
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            -- Document existing key chains
            spec = {
                { "<leader>b", group = "[B]uffer", mode = "n" },
                { "<leader>bd", group = "[B]uffer [D]elete", mode = "n" },
                { "<leader>bo", group = "[B]uffer [O]rder By", mode = "n" },
                { "<leader>c", group = "[C]ode", mode = "n" },
                { "<leader>d", group = "[D]ocument", mode = "n" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                { "<leader>k", group = "[K]eep", mode = { "n", "v" } },
                { "<leader>l", group = "[L]azy", mode = "n" },
                { "<leader>n", group = "[N]eorg: ", mode = "n" },
                { "<leader>r", group = "[R]ename", mode = "n" },
                { "<leader>s", group = "[S]earch", mode = "n" },
                { "<leader>t", group = "[T]oggle", mode = "n" },
                { "<leader>w", group = "[W]orkspace", mode = "n" },
                { "g", group = "[G]oto", mode = { "n", "v" } },
                { "z", group = "Folds, Cursor, Spell", mode = { "n", "v" } },
                { "[", group = "Previous", mode = { "n", "v" } },
                { "]", group = "Next", mode = { "n", "v" } },
                { "<leader>", group = "Leader Maps", mode = { "n", "v" } },
            },
        })
    end,
}
