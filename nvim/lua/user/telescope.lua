-- require('telescope').setup {
--   extensions = {
--     fzf = {
--       fuzzy = true,                    -- false will only do exact matching
--       override_generic_sorter = true,  -- override the generic sorter
--       override_file_sorter = true,     -- override the file sorter
--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                        -- the default case_mode is "smart_case"
--     }
--   }
-- }
-- -- To get fzf loaded and working with telescope, you need to call
-- -- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')
--
-- local builtin = require('telescope.builtin')
-- -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- -- vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true, sort = true }) end, {})
-- vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true, sort = true }) end, {})
-- -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fs', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
--
-- -- vim.api.nvim_set_keymap('n', '<leader>fe', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '/etc' } })<CR>]], { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap('n', '<leader>fde', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '/etc' } })<CR>]], { noremap = true, silent = true })
-- --
-- -- vim.api.nvim_set_keymap('n', '<leader>fw', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { vim.loop.os_homedir() } })<CR>]], { noremap = true, silent = true })
-- --
-- -- vim.api.nvim_set_keymap('n', '<leader>fdd', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { vim.loop.os_homedir() .. '/.dotfiles' } })<CR>]], { noremap = true, silent = true })
--
-- -- require("telescope").load_extension('zoxide')

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
