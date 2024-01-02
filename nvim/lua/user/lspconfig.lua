local lspconfig = require('lspconfig')

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)


-- Haskell

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
    -- settings = {
    --     languageServerHaskell = {
    --         formattingProvider = "ormolu"  -- or "stylish-haskell", "brittany", etc.
    --     }
    -- }
}


-- Ansible

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = "*-playbook.yaml",
--     callback = function()
--         vim.bo.filetype = "ansible"
--     end,
-- })

vim.api.nvim_create_augroup("YAMLConfig", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
    group = "YAMLConfig",
    pattern = "*.yaml",
    callback = function()
        local filename = vim.fn.expand("%:t")
        if not string.match(filename, "-playbook.yaml$") then
            -- Replace 'ansiblels' with the correct name if different
            vim.cmd("LspStop 1 (ansiblels)")
        end
    end,
})

lspconfig.ansiblels.setup{
    filetypes = { "yaml" },
    on_attach = function(client, bufnr)
        local function BufSetOption(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- Enable completion triggered by <c-x><c-o>
        BufSetOption('omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
    flags = {
        debounce_text_changes = 150,
    }
}


-- Yaml

lspconfig.yamlls.setup{
    settings = {
        yaml = {
            schemas = {
                -- kubernetes = "/*.yaml",
		["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
            },
        },
    },
}

lspconfig.nushell.setup{
  cmd = { "nu", "--lsp" },
  filetypes = { "nu" },
  single_file_support = true,
  -- root_dir = util.find_git_ancestor,
}
