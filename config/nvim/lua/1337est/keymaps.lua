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
