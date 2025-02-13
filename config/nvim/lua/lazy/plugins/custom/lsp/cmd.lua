local augroup = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local buf = vim.lsp.buf
local telebuilt = require('telescope.builtin')

autocmd("LspAttach", {
    desc = "Sets keybindings when a LSP attaches to a buffer",
    group = augroup,
    callback = function(e)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func,
                { buffer = e.buf, desc = "LSP: " .. desc })
        end

        map("gd", telebuilt.lsp_definitions, "[G]oto [D]efinition")
        map("gr", telebuilt.lsp_references, "[G]oto [R]eferences")
        map("gI", telebuilt.lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", telebuilt.lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", telebuilt.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", telebuilt.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", function() buf.rename() end, "[R]e[n]ame")
        map("<leader>ca", function() buf.code_action() end, "[C]ode [A]ction")
        map("gD", function() buf.declaration() end, "[G]oto [D]eclaration")
        map("K", function() buf.hover() end, "Shows Documentation")

        local client = vim.lsp.get_client_by_id(e.data.client_id)

        if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            autocmd('BufWritePre', {
                buffer = e.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = e.buf, id = client.id })
                end,
            })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local lsp_hl_group = vim.api.nvim_create_augroup(
                'lsp-highlight', { clear = false })
            autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = e.buf,
                group = lsp_hl_group,
                callback = buf.document_highlight,
            })
            autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = e.buf,
                group = lsp_hl_group,
                callback = buf.clear_references,
            })
            autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach',
                    { clear = true }),
                callback = function(event2)
                    buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint
                    .is_enabled { bufnr = e.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end,
})
