-- Sets <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true -- For my nerd font

vim.opt.guicursor = "" -- Disable cursor styling

vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Shows line # away from current line #
vim.opt.cursorline = true -- Show which line your cursor is on

vim.opt.tabstop = 4 -- tabs are 4 spaces
vim.opt.softtabstop = 4 -- indent 4 spaces visually
vim.opt.shiftwidth = 4 -- 4 spaces for (auto)indenting
vim.opt.expandtab = true -- Use appropriate spaces to insert tabs
vim.opt.smartindent = true -- Smart auto-indenting on new lines

vim.opt.wrap = false -- Don't wrap text
vim.opt.breakindent = true -- Makes text-wrap visually indented for continuity
vim.opt.linebreak = true -- Wraps words instead of characters

-- visual indicators for empty space characters. See :help listchars
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ", trail = "·", nbsp = "␣", extends = "▶", precedes = "◀"
}

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true -- Save undo history

vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.viewdir = vim.fn.stdpath("state") .. "/viewdir"

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.incsearch = true -- Shows pattern match as you type

vim.opt.termguicolors = true -- Enables 24-bit RGB color

vim.opt.scrolloff = 8 -- Minimal screen lines above/below the cursor
vim.opt.sidescrolloff = 3 -- Minimal screen lines to keep left/right

vim.opt.signcolumn = "yes" -- When and how to draw the signcolomn

-- Case-insensitive searching UNLESS \C or there's capital letters in the search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 50 -- In 50ms if nothing is typed, write to swap file

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live as you type
vim.opt.inccommand = "split"

vim.opt.colorcolumn = "101" -- Line at the nth column

vim.opt.mouse = "a" -- Enables mouse mode
vim.opt.mousescroll = "ver:1,hor:2"

vim.opt.showmode = false -- Don't show mode, since it's already in status line

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
