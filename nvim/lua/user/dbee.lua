require("dbee").setup({
    sources = { -- Add a source here
        require('dbee.sources').MemorySource:new({
            {
                name = "My Postgres Database",
                type = "postgres",
                url = "postgres://user:password@host:port/database_name",
            }
        })
    }
})


vim.api.nvim_set_keymap('n', '<Leader>bo', '<cmd>lua require("dbee").open()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>bc', '<cmd>lua require("dbee").close()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>bt', '<cmd>lua require("dbee").toggle()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>be', '<cmd>lua require("dbee").execute(query)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>bs', '<cmd>lua require("dbee").store(format, output, {noremap = true, silent = true})<CR>', {noremap = true, silent = true})
