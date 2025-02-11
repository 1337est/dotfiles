return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        local statusline = require 'mini.statusline'
        statusline.setup({})

        local pairs = require 'mini.pairs'
        pairs.setup({})

        local ai = require 'mini.ai'
        ai.setup({})
    end
}
