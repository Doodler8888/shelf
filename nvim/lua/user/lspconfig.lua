local lspconfig = require('lspconfig')

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)

lspconfig.hls.setup{
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    on_attach = function(client, bufnr)
        local function BufSetOption(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- Enable completion triggered by <c-x><c-o>
        BufSetOption('omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        languageServerHaskell = {
            formattingProvider = "ormolu"  -- or "stylish-haskell", "brittany", etc.
        }
    }
}

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.hs",
--     callback = function()
--         vim.lsp.buf.format({ async = false })
--     end,
-- })
