local augroup = vim.api.nvim_create_augroup
local _1337estGroup = augroup("1337est", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    desc = "Hightlight when yanking (copying) text",
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    desc = "Removes trailing whitespaces right before saving the file",
    group = _1337estGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Colors the matching paren pairs
vim.api.nvim_command([[ highlight MatchParen guibg=#0030F0 ]])

-- Enables wrap text for Markdown and Text files
vim.cmd([[autocmd BufEnter *.md,*.txt set wrap]])
-- Enable spell checking for Markdown and Text files
vim.cmd([[autocmd BufEnter *.md,*.txt set spell]])

-- Getting rid of auto-inserted comments
vim.cmd([[autocmd BufEnter * set formatoptions-=cro ]])