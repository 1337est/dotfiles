return {
    -- status line for Neovim
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "onedark",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {
                        'NvimTree',
                    },
                    winbar = {
                        'NvimTree',
                    },
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        icons_enabled = true, -- Enables the display of icons alongside the component.
                        icon = nil,
                        separator = nil, -- Determines what separator to use for the component.
                        cond = nil, -- Condition function, the component is loaded when the function returns `true`.
                        draw_empty = false, -- Whether to draw component even if it's empty.
                        color = nil, -- The default is your theme's color for that section and mode.
                        type = nil,
                        padding = 1, -- Adds padding to the left and right of components.
                        fmt = nil, -- Format function, formats the component's output.
                        on_click = nil, -- takes a function that is called when component is clicked with mouse.
                    },
                },
                lualine_b = {
                    {
                        "diagnostics",
                        sources = { 'nvim_diagnostic', 'coc' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            error = nil, -- Changes diagnostics' error color.
                            warn  = nil, -- Changes diagnostics' warn color.
                            info  = nil, -- Changes diagnostics' info color.
                            hint  = nil, -- Changes diagnostics' hint color.
                        },
                        -- NOTE: using the same as todo-comments
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        file_status = true, -- Displays file status (readonly status, modified status)
                        newfile_status = false, -- Display new file status (new file means no write after created)
                        path = 1, -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory
                        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = '[+]', -- Text to show when the file is modified.
                            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]', -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_x = {
                    {
                        "filetype",
                        colored = true, -- Displays filetype icon in color if set to true
                        icon_only = false, -- Display only an icon for filetype
                        icon = { align = 'left' }, -- Display filetype icon on the right hand side
                    },
                },
                lualine_y = {
                    {
                        "branch",
                        icon = { '', align = 'right' },
                        color = { fg = '#f2cc81', bg = nil }, -- NOTE: onedark deep bg_yellow
                    },
                    {
                        "diff",
                        colored = true, -- Displays a colored diff status if set to true
                        diff_color = {
                            -- Same color values as the general color option can be used here.
                            added    = nil, -- Changes the diff's added color
                            modified = nil, -- Changes the diff's modified color
                            removed  = nil, -- Changes the diff's removed color you
                        },
                        -- NOTE: using the same as gitsigns
                        symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
                        source = nil, -- A function that works as a data source for diff.
                    },
                },
                lualine_z = {
                    "location",
                    "progress",
                },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location", "progress" },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
