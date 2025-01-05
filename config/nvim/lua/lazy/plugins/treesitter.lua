return {
    -- syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                -- fullstack
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "sql",
                -- defaults
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                -- extra
                "bash",
                "c_sharp",
                "cpp",
                "go",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
                "haskell",
                "diff",
                "luadoc",
                "glsl",
                "cmake",
                "make",
                "ini",
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Autoinstall languages that are not installed
            auto_install = true,
            ignore_install = { "javascript" },
            highlight = {
                enable = true,
                -- list of language that will be disabled
                disable = {},
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } },
        })
    end,
}
