local M = {}

M.setup = function(bufnr, client)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func,
            { buffer = bufnr, desc = "LSP: " .. desc })
    end

    local telebuilt = require('telescope.builtin')
    map("gd", telebuilt.lsp_definitions, "[G]oto [D]efinition")
    map("gD", function() vim.lsp.buf.declaration() end, "[G]oto [D]eclaration")
    map("gI", telebuilt.lsp_implementations, "[G]oto [I]mplementation")
    map("gr", telebuilt.lsp_references, "[G]oto [R]eferences")

    map("<leader>D", telebuilt.lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", telebuilt.lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", telebuilt.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    map("<leader>rn", function() vim.lsp.buf.rename() end, "[R]e[n]ame")
    map("<leader>ca", function() vim.lsp.buf.code_action() end, "[C]ode [A]ction")

    map("K", function() vim.lsp.buf.hover() end, "Shows Documentation")

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, '[T]oggle Inlay [H]ints')
    end
end

return M
