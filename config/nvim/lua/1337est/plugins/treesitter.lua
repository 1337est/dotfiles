return {
    -- syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
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
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
    },
    config = function(_, opts)
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup(opts)

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
}
