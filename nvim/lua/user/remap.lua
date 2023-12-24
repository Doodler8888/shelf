vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)
-- vim.api.nvim_set_keymap('n', 'gq', [[<Cmd>normal! gq<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('fzf-lua').files({ cwd = '~/.git' })<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Keep center view
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Void a pasted upon word
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Start replacing the word that you was on
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make a file executable
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })
-- Buffers
vim.keymap.set("n", '<Tab>', ":b#<CR>")

vim.api.nvim_set_keymap('i', '<S-Tab>', [[<C-\><C-o>:normal! 4X<CR>]], { noremap = true, silent = true })

-- LSP
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

-- Remaps for different types of autocompletion
-- vim.api.nvim_set_keymap('i', '<\\-f>', '<C-x><C-f>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<\\-l>', '<C-x><C-l>', { noremap = true, silent = true })

-- Disable Control+c  
vim.api.nvim_set_keymap('n', '<C-c>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-c>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-c>', '<Nop>', { noremap = true, silent = true })

-- -- Splits
-- vim.api.nvim_set_keymap('n', '<M-v>', ':rightbelow vertical split .<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-s>', ':belowright split .<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-h>', '<C-w>h', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-l>', '<C-w>l', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-k>', '<C-w>k', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-j>', '<C-w>j', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<M-w>', ':close<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<Leader>fd', ':find ', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<Leader>zz', ':Z ', {noremap = true})

-- Quit the terminal mode (but not the terminal emulation)
vim.api.nvim_set_keymap('t', '<S-Tab>', '<C-\\><C-n>', {noremap = true})
-- vim.api.nvim_set_keymap('t', '<M-e>', '<C-\\><C-n>', {noremap = true})

-- Toggle colorcolumn
vim.cmd('command! Column execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")')

-- Keep selection and indent left and right in visual mode
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })

-- Messages command
vim.cmd([[
  command! Messages execute 'botright 10new' | execute 'redir @a' | execute 'messages' | execute 'redir END' | execute 'put a' | execute 'normal gg'
]])

vim.api.nvim_set_keymap('i', '<C-f>', '<Esc>la', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Esc>ha', {noremap = true})
vim.api.nvim_set_keymap('i', '<M-w>', '<Esc> wi', {noremap = true})
vim.api.nvim_set_keymap('i', '<M-b>', '<Esc> bi', {noremap = true})
-- vim.api.nvim_set_keymap('i', '<C-o>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-i>', '<Esc>I', {noremap = true})
vim.api.nvim_set_keymap('i', '<M-a>', '<Esc>A', {noremap = true})

-- Create a new tab with 'Alt-T'
vim.api.nvim_set_keymap('n', '<Leader>tn', ':tabnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>tx', ':tabclose<CR>', {noremap = true, silent = true})

-- Move between tabs with 
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>'..i, i..'gt', {noremap = true, silent = true})
end

-- -- Avoid selecting newline character when jumping to previous paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '[{', ':<C-U>normal! gv[{v<CR>', {noremap = true})
--
-- -- Avoid selecting newline character when jumping to next paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '}]', ':<C-U>normal! gv}]v<CR>', {noremap = true})-- Avoid selecting newline character when jumping to previous paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '[{', ':<C-U>normal! gv[{v<CR>', {noremap = true})
--
-- -- Avoid selecting newline character when jumping to next paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '}]', ':<C-U>normal! gv}]v<CR>', {noremap = true})-- Avoid selecting newline character when jumping to previous paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '[{', ':<C-U>normal! gv[{v<CR>', {noremap = true})
--
-- -- Avoid selecting newline character when jumping to next paragraph in visual mode
-- vim.api.nvim_set_keymap('x', '}]', ':<C-U>normal! gv}]v<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Leader>ee', ':SudaWrite ', {noremap = true})

