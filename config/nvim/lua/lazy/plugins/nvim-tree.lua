return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup {}

        -- to prevent statusline from showing for NvimTree
        require("nvim-tree.api").events.subscribe("TreeOpen", function()
            vim.wo.statusline = ' '
        end)
    end,
}
