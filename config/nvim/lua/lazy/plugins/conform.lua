return {
    -- Autoformatting
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    config = function()
        require("conform").setup({
            -- Conform will notify you when a formatter errors
            notify_on_error = false,
            -- Set the log level. Use `:ConformInfo` to see the location of the log file.
            log_level = vim.log.levels.ERROR,
            -- Conform will notify you when no formatters are available for the buffer
            notify_no_formatters = true,
            -- If this is set, Conform will run the formatter on save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            -- Map of filetype to formatters
            formatters_by_ft = {
            },
        })
    end,
}
