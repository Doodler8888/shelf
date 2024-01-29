-- Function to toggle ALE
function _G.toggle_ale()
  if vim.g.ale_enabled == 1 then
    vim.cmd('ALEDisable')
  else
    vim.cmd('ALEEnable')
  end
end

vim.api.nvim_set_keymap('n', '<leader>at', '<cmd>lua toggle_ale()<CR>', { noremap = true, silent = true })

vim.g.ale_linters = {
  lua = {},
  haskell = {},
  nim = {},
  go = {'cspell'},
  yaml = {},
  terraform = {},
  rust = {},
}

vim.g.ale_linters_ignore = {
  go = {'golangci-lint'},
}

vim.g.ale_lint_on_text_changed = 'always'


-- Available Linters: ['bingo', 'cspell', 'gobuild', 'gofmt', 'golangci-lint',
-- 'gopls', 'gosimple', 'gotype', 'govet', 'golangserver', 'revive',
-- 'staticcheck']
--    Linter Aliases:
-- 'gobuild' -> ['go build']
-- 'govet' -> ['go vet']
--   Enabled Linters: ['gofmt', 'golangci-lint', 'gopls', 'govet']
--   Ignored Linters: []

