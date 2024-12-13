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

autocmd("LspAttach", {
	desc = "Sets keybindings when a LSP attaches to a buffer",
	group = _1337estGroup,
	callback = function(e)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = e.buf, desc = "LSP: " .. desc })
		end

		map("gd", function()
			vim.lsp.buf.definition()
		end, "[G]oto [D]efinition")
		map("<leader>D", function()
			vim.lsp.buf.type_definition()
		end, "Type [D]efinition")
		map("gD", function()
			vim.lsp.buf.declaration()
		end, "[G]oto [D]eclaration")
		map("gr", function()
			vim.lsp.buf.references()
		end, "[G]oto [R]eferences")
		map("gI", function()
			vim.lsp.buf.implementation()
		end, "[G]oto [I]mplementation")
		map("K", function()
			vim.lsp.buf.hover()
		end, "Shows Documentation")
		map("<leader>ws", function()
			vim.lsp.buf.workspace_symbol()
		end, "[W]orkspace [S]ymbols")
		map("<leader>ds", function()
			vim.lsp.buf.document_symbol()
		end, "[D]ocument [S]ymbols")
		map("<leader>ca", function()
			vim.lsp.buf.code_action()
		end, "[C]ode [A]ction")
		map("<leader>rn", function()
			vim.lsp.buf.rename()
		end, "[R]e[n]ame")
	end,
})

-- Colors the matching paren pairs
vim.api.nvim_command([[ highlight MatchParen guibg=#0030F0 ]])

-- Enables wrap text for Markdown and Text files
vim.cmd([[autocmd BufEnter *.md,*.txt set wrap]])
-- Enable spell checking for Markdown and Text files
vim.cmd([[autocmd BufEnter *.md,*.txt set spell]])

-- Getting rid of auto-inserted comments
vim.cmd([[autocmd BufEnter * set formatoptions-=cro ]])
