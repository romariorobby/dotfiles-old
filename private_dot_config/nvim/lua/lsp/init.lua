vim.fn.sign_define("LspDiagnosticsSignError",
                   {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})

vim.cmd('nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>')
vim.cmd('nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>')
vim.cmd('nnoremap <silent> K :Lspsaga hover_doc<CR>')
vim.cmd('nnoremap <silent> gx :cclose<CR>')

vim.cmd('nnoremap <silent> <C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
vim.cmd('nnoremap <silent> <C-b> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>')
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
-- Set autocommands conditional on server_capabilities
--
-- vim.lsp.protocol.CompletionTriggerKind = {
--     "   (Text) ",
--     "   (Method)",
--     "   (Function)",
--     "   (Constructor)",
--     " ﴲ  (Field)",
--     "[] (Variable)",
--     "   (Class)",
--     " ﰮ  (Interface)",
--     "   (Module)",
--     " 襁 (Property)",
--     "   (Unit)",
--     "   (Value)",
--     " 練 (Enum)",
--     "   (Keyword)",
--     " ﬌  (Snippet)",
--     "   (Color)",
--     "   (File)",
--     "   (Reference)",
--     "   (Folder)",
--     "   (EnumMember)",
--     " ﲀ  (Constant)",
--     " ﳤ  (Struct)",
--     "   (Event)",
--     "   (Operator)",
--     "   (TypeParameter)"
-- }
require('vim.lsp.protocol').CompletionItemKind = {
      '  Text';          -- = 1
      '  Function';      -- = 2;
      '  Method';        -- = 3;
      '  Constructor';   -- = 4;
      '  Field';         -- = 5;
      '  Variable';      -- = 6;
      '  Class';         -- = 7;
      '  Interface';     -- = 8;
      '  Module';        -- = 9;
      '  Property';      -- = 10;
      '  Unit';          -- = 11;
      '  Value';         -- = 12;
      '  Enum';          -- = 13;
      '  Keyword';       -- = 14;
      '  Snippet';       -- = 15;
      '  Color';         -- = 16;
      '  File';          -- = 17;
      '  Reference';     -- = 18;
      '  Folder';        -- = 19;
      '  EnumMember';    -- = 20;
      '  Constant';      -- = 21;
      '  Struct';        -- = 22;
      '  Event';         -- = 23;
      '  Operator';      -- = 24;
      '  TypeParameter'; -- = 25;
}
-- rgba(131, 165, 152, 0.4)
-- rgb(250, 189, 47)
local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guifg=#fabd2f guibg=#141414
      hi LspReferenceText cterm=bold ctermbg=red guifg=#00 guibg=#242424
      hi LspReferenceWrite cterm=bold ctermbg=red guifg=#458588 guibg=#141414
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end

function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

return lsp_config

