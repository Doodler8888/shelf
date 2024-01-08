require('telescope').setup{
 defaults = {
 find_command = { 'fd', '--type=f', '--hidden', '--exclude=.git', '--exclude=node_modules' },
 },
 extensions = {
 fzf = {
   fuzzy = true,               -- false will only do exact matching
   override_generic_sorter = true, -- override the generic sorter
   override_file_sorter = true,  -- override the file sorter
   case_mode = "smart_case",     -- or "ignore_case" or "respect_case"
                               -- the default case_mode is "smart_case"
 },
 zoxide = {}
 }
}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('zoxide')

vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ hidden = true, sort = true })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', [[<Cmd>lua require('telescope.builtin').find_files({ hidden = true, sort = true, cwd = '~/' })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fz', [[<cmd>lua require('telescope').extensions.zoxide.list()<CR>]], { noremap = true, silent = true })
