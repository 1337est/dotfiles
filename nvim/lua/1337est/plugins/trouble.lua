return {
	--[[
    Shows diagnostics, references, telescope results, quickfixes, and
    location lists to help you solve all the trouble your code is causing.
    --]]
	"folke/trouble.nvim",
	config = function()
		local trouble = require("trouble")
		trouble.setup({
			icons = false,
		})

		vim.keymap.set("n", "<leader>tt", function()
			trouble.toggle()
		end, { desc = "[T]oggle [t]rouble" })

		vim.keymap.set("n", "[t", function()
			trouble.previous({ skip_groups = true, jump = true })
		end, { desc = "Previous [t]rouble" })

		vim.keymap.set("n", "]t", function()
			trouble.next({ skip_groups = true, jump = true })
		end, { desc = "Next [t]rouble" })
	end,
}
