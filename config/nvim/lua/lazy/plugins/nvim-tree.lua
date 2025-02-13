return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
        require("nvim-tree.api").events.subscribe("TreeOpen", function()
            vim.wo.statusline = ' '
        end)
    end,
}
