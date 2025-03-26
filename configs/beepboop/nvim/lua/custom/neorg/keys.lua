-- .norg specific keymaps
local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, "<Plug>(neorg." .. func .. ")",
        { buffer = true, desc = "neorg: " .. desc })
end

-- task/todo manipulations
map("n", "<C-Space>", "qol.todo-items.todo.task-cycle", "Task cycle")
map("n", "<leader>ta", "qol.todo-items.todo.task-ambiguous", "[t]oggle [a]mbiguous")
map("n", "<leader>tc", "qol.todo-items.todo.task-cancelled", "[t]ask [c]ancelled")
map("n", "<leader>td", "qol.todo-items.todo.task-done", "[t]ask [d]one")
map("n", "<leader>th", "qol.todo-items.todo.task-on-hold", "[t]ask on [h]old")
map("n", "<leader>ti", "qol.todo-items.todo.task-important", "[t]ask [i]mportant")
map("n", "<leader>tp", "qol.todo-items.todo.task-pending", "[t]ask [p]ending")
map("n", "<leader>tr", "qol.todo-items.todo.task-recurring", "[t]ask [r]ecurring")
map("n", "<leader>tu", "qol.todo-items.todo.task-undone", "[t]ask [u]ndone")
-- list converting/toggling
map("n", "<leader>li", "pivot.list.invert", "[l]ist [i]nvert")
map("n", "<leader>lt", "pivot.list.toggle", "[l]ist [t]oggle")

-- link hopping
map("n", "<CR>", "esupports.hop.hop-link", "Open link")
map("n", "<M-CR>", "esupports.hop.hop-link.vsplit", "Open link vsplit")
map("n", "<M-t>", "esupports.hop.hop-link.tab-drop", "Open link new [t]ab")
-- inserting date links
map("i", "<M-d>", "tempus.insert-date.insert-mode", "insert [d]ate")
map("n", "<leader>id", "tempus.insert-date", "insert [d]ate")

-- heirarchy demotion
map("i", "<C-d>", "promo.demote", "[d]emote single")
map("n", "<,", "promo.demote", "[d]emote single")
map("n", "<<", "promo.demote.nested", "[d]emote nested")
map("v", "<", "promo.demote.range", "[d]emote range")
-- heirarchy promotion
map("i", "<C-t>", "promo.promote", "[p]romote single")
map("n", ">.", "promo.promote", "[p]romote single")
map("n", ">>", "promo.promote.nested", "[p]romote nested")
map("v", ">", "promo.promote.range", "[p]romote range")

-- Continue the neorg indentation schema on next line
map("i", "<M-CR>", "itero.next-iteration", "Cont. Schema")
-- open code tag in a temporary buffer
map("n", "<leader>mc", "looking-glass.magnify-code-block", "[m]agnify code")

-- Toggle the neorg concealer
vim.keymap.set("n", "<leader>tm", function()
    vim.cmd.Neorg("toggle-concealer")
end, { buffer = true, desc = "neorg: [t]oggle [m]arkup" })
