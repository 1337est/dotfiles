-- keymaps to call telescope functions
local telebuilt = require("telescope.builtin")
local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func,
        { desc = "TEL: " .. desc })
end

map("<leader>sh", telebuilt.help_tags, "[S]earch [H]elp")
map("<leader>sk", telebuilt.keymaps, "[S]earch [K]eymaps")
map("<leader>sf", telebuilt.find_files, "[S]earch [F]iles")
map("<leader>ss", telebuilt.builtin, "[S]earch [S]elect Telescope")
map("<leader>sw", telebuilt.grep_string, "[S]earch current [W]ord")
map("<leader>sg", telebuilt.live_grep, "[S]earch by [G]rep")
map("<leader>sd", telebuilt.diagnostics, "[S]earch [D]iagnostics")
map("<leader>sr", telebuilt.resume, "[S]earch [R]esume")
map("<leader>s.", telebuilt.oldfiles, '[S]earch Recent Files ("." for repeat)')
map("<leader><leader>", telebuilt.buffers, "[ ] Find existing buffers")

-- Search in current buffer
map("<leader>/", function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    telebuilt.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, "[/] Fuzzily search in current buffer")

-- Search open files
map("<leader>s/", function()
    telebuilt.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, "[S]earch [/] in Open Files")

-- Shortcut for searching your Neovim configuration files
map("<leader>sn", function()
    telebuilt.find_files({ cwd = vim.fn.stdpath("config") })
end, "[S]earch [N]eovim files")
