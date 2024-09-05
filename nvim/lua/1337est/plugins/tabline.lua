return {
	-- show buffers as tabs
	"romgrk/barbar.nvim",
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function()
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
		end

		-- Move to previous/next
		map("<A-p>", "<Cmd>BufferPrevious<CR>", "[P]revious Buffer")
		map("<A-n>", "<Cmd>BufferNext<CR>", "[N]ext Buffer")
		-- Re-order to previous/next
		map("<A-,>", "<Cmd>BufferMovePrevious<CR>", "Move Buffer Left")
		map("<A-.>", "<Cmd>BufferMoveNext<CR>", "Move Buffer Right")
		-- Close commands
		map("<leader>bdc", "<Cmd>BufferClose<CR>", "[B]uffer [D]elete [C]urrent")
		map("<leader>bda", "<Cmd>BufferCloseAllButCurrent<CR>", "[B]uffer [D]elete [A]ll But Current")
		-- Magic buffer-picking mode
		map("<leader>bs", "<Cmd>BufferPick<CR>", "[B]uffer [S]elect")
		-- Sort automatically by...
		map("<leader>bob", "<Cmd>BufferOrderByBufferNumber<CR>", "[B]uffer [O]rder By [B]uffer Number")
		map("<leader>bon", "<Cmd>BufferOrderByName<CR>", "[B]uffer [O]rder By [N]ame")
		map("<leader>bod", "<Cmd>BufferOrderByDirectory<CR>", "[B]uffer [O]rder By [D]irectory")
		map("<leader>bol", "<Cmd>BufferOrderByLanguage<CR>", "[B]uffer [O]rder By [L]anguage")
		map("<leader>bow", "<Cmd>BufferOrderByWindowNumber<CR>", "[B]uffer [O]rder By [W]indow Number")

		require("barbar").setup({})
	end,
}
