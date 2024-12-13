-- Preserves text instead of replacing the register with the deleted text by
-- deleting text into the 'blackhole' register "_d.
vim.keymap.set("v", "<leader>kp", [["_dP]], { desc = "[K]eep current, [p]aste" })
vim.keymap.set({ "n", "v" }, "<leader>kd", [["_d]], { desc = "[K]eep current, [d]elete" })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- C-hjkl for window movement
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Navigate to left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Navigate to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Navigate to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Navigate to right window" })

-- Term Toggle Function
local term_buf = nil
local term_win = nil

function TermToggle(height)
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.cmd("hide")
	else
		vim.cmd("botright new")
		local new_buf = vim.api.nvim_get_current_buf()
		vim.cmd("resize " .. height)
		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			vim.cmd("buffer " .. term_buf) -- go to terminal buffer
			vim.cmd("bd " .. new_buf) -- cleanup new buffer
		else
			vim.cmd("terminal")
			term_buf = vim.api.nvim_get_current_buf()
			vim.wo.number = false
			vim.wo.relativenumber = false
			vim.wo.signcolumn = "no"
		end
		vim.cmd("startinsert!")
		term_win = vim.api.nvim_get_current_win()
	end
end

-- Term Toggle Keymaps
vim.keymap.set(
	"n",
	"<leader>tt",
	":lua TermToggle(20)<CR>",
	{ noremap = true, silent = true, desc = "[T]oggle [t]erminal" }
)
vim.keymap.set(
	"t",
	"<leader>tt",
	"<C-\\><C-n>:lua TermToggle(20)<CR>",
	{ noremap = true, silent = true, desc = "[T]oggle [t]erminal" }
)
