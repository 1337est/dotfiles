return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            disable_move = true,
            shortcut_type = 'letter',
            shuffle_letter = false,
            letter_list = 'abcdefghijklmnopqrstuvwxyz',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = '[ Neorg]',
                        group = '@module',
                        action = 'Neorg workspace main',
                        key = 'n',
                    },
                    {
                        desc = '[ Journal]',
                        group = '@function',
                        action = 'Neorg journal',
                        key = 'j',
                    },
                    {
                        desc = '[󰄬 Todo]',
                        group = '@neorg.todo_items.done',
                        action = 'e ~/Notes/neorg/todo.norg',
                        key = 't',
                    },
                    {
                        desc = '[ dotfiles]',
                        group = '@markup',
                        action = 'Telescope find_files cwd=~/Github/dotfiles',
                        key = 'd',
                    },
                },
            },
        }
    end,
}
