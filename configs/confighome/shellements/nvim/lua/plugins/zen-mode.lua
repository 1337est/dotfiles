return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                backdrop = 1.0,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "yes",
                    number = true,
                    relativenumber = true,
                    cursorline = true,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = true,
                    showcmd = true,
                    laststatus = 2,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = true },
                tmux = { enabled = false },
                todo = { enabled = false },
                -- this will change the font size on kitty when in zen mode
                -- to make this work, you need to set the following kitty options:
                -- - allow_remote_control socket-only
                -- - listen_on unix:/tmp/kitty
                kitty = {
                    enabled = false,
                    font = "+4",
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                vim.opt.showmode = true -- Don't show mode, since it's already in status line
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                vim.opt.showmode = false -- Don't show mode, since it's already in status line
            end,
        })
        vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "[z]enmode" })
    end,
}
