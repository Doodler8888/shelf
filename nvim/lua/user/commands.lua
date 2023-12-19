-- Open netrw in specific directories
vim.cmd('command! Dot Oil ~/.dotfiles')
vim.cmd('command! Symbols Oil /usr/share/X11/xkb/symbols')
vim.cmd('command! Bash Oil ~/.dotfiles/bash')
vim.cmd('command! Nvim Oil ~/.dotfiles/nvim')
vim.cmd('command! Emacs Oil ~/.emacs.d/')
vim.cmd('command! Home Oil ~/')

-- Open specific files
-- vim.cmd('command! Bsh edit $HOME/.dotfiles/bash/.bashrc')
-- vim.cmd('command! Inpt edit $HOME/.dotfiles/bash/.inputrc')
-- vim.cmd('command! Nvm edit $HOME/.dotfiles/nvim/init.lua')
-- vim.cmd('command! Nvm tcd $HOME/.dotfiles/nvim | edit init.lua')
-- vim.cmd('command! Emc edit $HOME/.emacs.d/config.org')
