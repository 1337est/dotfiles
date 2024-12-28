return {
    -- FIX: (or FIXME, BUG, FIXIT, ISSUE) - Something that needs fixin
    -- TODO: Something you want to do
    -- HACK: Weird code warning
    -- WARN: (or WARNING, XXX) - Warning about something, so be cautious
    -- PERF: (or OPTIM, PERFORMANCE, OPTIMIZE) - Optimization tag
    -- NOTE: Use for leaving notes.
    -- TEST: (or TESTING, PASSED, FAILED) - a test

    -- The above now has a nice highlighting effect for easily viewing comments
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup({
            keywords = {
                FIX = { icon = " ", color = "error" },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            colors = {
                -- hl groups to match with last being a fallback color
                -- I've changed these to match what ondark.nvim sets
                -- reference: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua
                error = { "#f65866" },   -- red
                warning = { "#efbd5d" }, -- yellow
                info = { "#41a7fc" },    -- blue
                hint = { "#8bcd5b" },    -- green
                default = { "#c75ae8" }, -- purple
                test = { "#34bfd0" },    -- cyan
            },
        })
    end,
}
