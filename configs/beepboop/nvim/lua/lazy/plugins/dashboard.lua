return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    { desc = '[  Github]', group = 'DashboardShortCut' },
                    { desc = '[  1337est]', group = 'DashboardShortCut' },
                },
            },
        }
    end,
}
