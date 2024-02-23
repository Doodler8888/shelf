-- Open netrw in specific directories
-- vim.cmd('command! Dot Oil ~/.dotfiles')
-- vim.cmd('command! Symbols Oil /usr/share/X11/xkb/symbols')
-- vim.cmd('command! Bash Oil ~/.dotfiles/bash')
-- vim.cmd('command! Nvim Oil ~/.dotfiles/nvim')
-- vim.cmd('command! Emacs Oil ~/.emacs.d/')
-- vim.cmd('command! Home Oil ~/')

-- Open specific files
vim.cmd('command! Bsh lcd $HOME/.dotfiles/bash | edit .bashrc')
vim.cmd('command! Inpt lcd $HOME/.dotfiles/bash | edit .inputrc')
vim.cmd('command! Nvm lcd $HOME/.dotfiles/nvim | edit init.lua')
vim.cmd('command! Zsh lcd $HOME/.dotfiles/zsh | edit .zshrc')
vim.cmd('command! SZsh lcd $HOME/.secret_dotfiles/zsh | edit .zshrc')
vim.cmd('command! Bsh lcd $HOME/.dotfiles/bash | edit .bashrc')
vim.cmd('command! Emc lcd $HOME/.emacs.d | edit config.org')
vim.cmd('command! Zlj lcd $HOME/.dotfiles/zellij | edit config.kdl')
vim.cmd('command! Nu lcd $HOME/.dotfiles/nu | edit config.nu')
vim.cmd('command! Hosts lcd /etc/ansible | edit hosts')
vim.cmd('command! Books lcd $HOME/.secret_dotfiles/ansible/playbooks')
vim.cmd('command! Keys lcd $HOME/.secret_dotfiles/zsh | edit keys.sh')
vim.cmd('command! Str lcd $HOME/.dotfiles/starship/ | edit starship.toml')
vim.cmd('command! Scr lcd $HOME/.dotfiles/scripts | Oil ~/.dotfiles/scripts')
vim.cmd('command! Raku lcd $HOME/.dotfiles/scripts/raku/ | Oil ')

-- :set filetype?

