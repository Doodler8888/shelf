local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fh', function() builtin.find_files({ hidden = true }) end, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- vim.api.nvim_set_keymap('n', '<leader>fe', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '/etc' } })<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fde', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '/etc' } })<CR>]], { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap('n', '<leader>fw', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { vim.loop.os_homedir() } })<CR>]], { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap('n', '<leader>fdd', [[<cmd>lua require('telescope.builtin').find_files({ search_dirs = { vim.loop.os_homedir() .. '/.dotfiles' } })<CR>]], { noremap = true, silent = true })

-- require("telescope").load_extension('zoxide')
