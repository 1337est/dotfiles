return {
    -- Colorscheme
    "navarasu/onedark.nvim",
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("onedark")
        vim.cmd.hi("Comment gui=none")
    end,
    config = function()
        require("onedark").setup({
            -- Main options --
            style = "deep", -- dark, darker, cool, deep, warm, warmer, light
            transparent = true,
            ending_tildes = true,
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

            -- toggle theme style ---
            toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            toggle_style_list = { 'darker', 'dark', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

            -- Change code style --
            -- Options are italic, bold, underline, none
            -- You can configure multiple syles with commas e.g. 'italic,bold'
            code_style = {
                comments = "none",
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },

            -- Lualine option --
            lualine = {
                transparent = false,
            },

            -- Custom Highlights --
            colors = {},     -- Override default colors
            highlights = {}, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        })
    end,
}
