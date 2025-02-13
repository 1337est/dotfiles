return {
    -- Adds indentation guides between blocks of code
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup {}
    end,
}
