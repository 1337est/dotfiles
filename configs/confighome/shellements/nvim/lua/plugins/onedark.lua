return {
    "navarasu/onedark.nvim",
    enabled = true,
    priority = 1000,
    config = function()
        require("onedark").setup {
            style = "cool",
            transparent = true,
            ending_tildes = true,
        }
        require('onedark').load()
        vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
        vim.api.nvim_set_hl(0, "@markup.underline", { underline = true })
        vim.api.nvim_set_hl(0, "@text.strong", { bold = true })
        vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
    end,
}
