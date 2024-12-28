return {
    -- Visual colors in editor: Red #0F0 #0000FF
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end,
}
