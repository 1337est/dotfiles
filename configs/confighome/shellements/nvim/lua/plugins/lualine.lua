return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
        require("lualine").setup {
            options = {
                theme = "onedark",
                disabled_filetypes = {
                    statusline = { 'NvimTree' },
                    winbar = { 'NvimTree' },
                },
            },
            sections = {
                lualine_a = { { "mode" } },
                lualine_b = { { "diagnostics", symbols = symbols } },
                lualine_c = { { "filename", path = 4 } },
                lualine_x = { {
                    "filetype",
                    icon = { align = 'left' }
                } },
                lualine_y = {
                    {
                        "branch",
                        color = { fg = '#f2cc81', bg = nil }
                    },
                    { "diff" },
                },
                lualine_z = { "location", "progress" },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_z = { "location", "progress" },
            },
        }
    end,
}
