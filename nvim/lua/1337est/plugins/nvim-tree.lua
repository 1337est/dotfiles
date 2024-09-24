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
				preserve_window_proportions = true,
				number = false,
				relativenumber = false,
				width = {
					min = 30,
					max = 50,
					padding = 1,
				},
				signcolumn = "no",
			},
			renderer = { group_empty = false },
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			actions = {
				open_file = {
					resize_window = false,
				},
			},
		})
	end,
}
