return {
	-- Popup menu for keymaps
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		-- normal mode
		require("which-key").add({
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>bd", group = "[B]uffer [D]elete" },
			{ "<leader>bo", group = "[B]uffer [O]rder By" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>h", group = "Git [H]unk" },
			{ "<leader>h_", hidden = true },
			{ "<leader>k", group = "[K]eep" },
			{ "<leader>l", group = "[L]azy" },
			{ "<leader>n", group = "[N]eorg: " },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>t_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
			{ "g", group = "[G]oto" },
			{ "z", group = "Folds, Cursor, Spell" },
			{ "[", group = "Previous" },
			{ "]", group = "Next" },
			{ "<leader>", group = "Leader Maps" },
		})
		-- visual mode
		require("which-key").add({
			{ "<leader>h", desc = "Git [H]unk", mode = "v" },
			{ "<leader>k", desc = "[K]eep", mode = "v" },
			{ "<leader>", desc = "Leader Maps", mode = "v" },
			{ "g", desc = "[G]oto", mode = "v" },
			{ "z", desc = "Fold", mode = "v" },
			{ "[", desc = "Previous", mode = "v" },
			{ "]", desc = "Next", mode = "v" },
		})
	end,
}
