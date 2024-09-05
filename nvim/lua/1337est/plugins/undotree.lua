return {
	-- A tree that shows your undo history
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
			desc = "[U]ndotree",
		})
	end,
}
