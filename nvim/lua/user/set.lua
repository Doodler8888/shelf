vim.opt.nu = true vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backupdir = '/tmp/nvim-backup//'
vim.opt.backup = true

vim.opt.undodir = '/tmp/nvim-undo//'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = "auto"
vim.opt.shiftwidth = 2

-- Disable 'scrolloff' when using 'H' and 'L'
vim.opt.scrolloff = 8
vim.api.nvim_set_keymap('n', 'H', ':set scrolloff=0<CR>H:set scrolloff=8<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', ':set scrolloff=0<CR>L:set scrolloff=8<CR>', { noremap = true })

-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true
vim.opt.conceallevel = 0

vim.opt.shada = "'20,<50,s10,h"
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]

-- vim.o.selection = "exclusive"

vim.opt.textwidth = 80
vim.opt.formatoptions:append("cq")

-- vim.cmd[[set spell]]
-- vim.cmd[[set spelllang=en_us]]

--  Prevent auto commenting on new lines
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- -- Folding autosave (the setting causing bug(?) where it switches the current directory to nvim where i open .bashrc)
vim.cmd [[ set viewoptions=folds,cursor ]]
vim.cmd [[ autocmd BufWinLeave * silent! mkview ]]
vim.cmd [[ autocmd BufWinEnter * silent! loadview ]]

vim.cmd([[
  augroup yaml_comment_indent
    autocmd!
    autocmd InsertEnter,BufRead * lua if vim.fn.getline('.'):match('^%s*#') then vim.bo.autoindent = false else vim.bo.autoindent = true end
  augroup END
]])

-- vim.cmd [[ let g:suda_smart_edit = 1 ]]

-- vim.cmd [[ filetype plugin on ]]
-- vim.cmd [[ set path=.,** ]]
-- vim.cmd [[command! -nargs=1 Grep execute 'vimgrep /' . <q-args> . '/ **/*' | copen]]
--
-- -- vim.opt.shell = '/usr/bin/bash --login'
--
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- -- define a neovim command 'ToggleColorColumn'
-- vim.cmd([[
--   command! ToggleColorColumn if &colorcolumn == '80' | set colorcolumn= | else | set colorcolumn=80 | endif
-- ]])
--
-- -- keybinding for the command to quickly toggle 'colorcolumn'
-- vim.api.nvim_set_keymap('n', '<F6>', ':ToggleColorColumn<CR>', { noremap = true, silent = true })
--
--
-- -- vim.o.autochdir = true
