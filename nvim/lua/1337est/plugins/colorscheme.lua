return {
	-- Colorscheme
	"navarasu/onedark.nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("onedark")
		vim.cmd.hi("Comment gui=none")
	end,
	config = function()
		require("onedark").setup({
			style = "deep", -- dark, darker, cool, deep, warm, warmer, light
			transparent = true,
			ending_tildes = true,
			-- Change code style
			-- Options are italic, bold, underline, none
			-- You can configure multiple syles with commas e.g. 'italic,bold'
			code_style = {
				comments = "none",
			},
			-- Lualine option
			lualine = {
				transparent = true,
			},
		})
	end,
}
