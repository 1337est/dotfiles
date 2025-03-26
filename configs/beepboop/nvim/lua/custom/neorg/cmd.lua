vim.api.nvim_create_autocmd("Filetype", {
    desc = "Settings for when a .norg file is opened.",
    pattern = "norg",
    callback = function()
        require("custom.neorg.keys")
        -- any other .norg specific options go here
    end,
})
