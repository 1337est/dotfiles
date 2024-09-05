return {
	-- File Explorer for Neovim
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>no", "<cmd>NvimTreeOpen<CR>", { desc = "[N]vim-tree: [O]pen" })
		vim.keymap.set("n", "<leader>nc", "<cmd>NvimTreeClose<CR>", { desc = "[N]vim-tree: [C]lose" })
		require("nvim-tree").setup({
			sort = { sorter = "case_sensitive" },
			view = {
				side = "left",
				number = false,
				relativenumber = false,
				width = 30,
				signcolumn = "no",
			},
			renderer = { group_empty = false },
			filters = {
				dotfiles = false,
				git_ignored = true,
			},
		})
	end,
}
