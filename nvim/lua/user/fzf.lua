require'fzf-lua'.setup {
  git = {
    files = {
      cmd = "git ls-files --exclude-standard",
      rooter = { ".git", "lazy-lock.lua" },
    },
  },
}
