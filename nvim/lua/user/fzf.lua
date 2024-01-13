require('fzf-lua').setup {
  'telescope',
  -- hls = {
  --   border = "FloatBorder",
  --   cursorline = "FloatBorder",
  --   cursor = "FloatBorder",
  -- },
  -- fzf_colors = {
  --   ["gutter"] = {"bg", "CursorLine"},
  --   -- ["bg+"] = {"bg", "Normal"},
  -- },
  -- fzf_opts = {
  --   ['--color', 'bg+:#1E1E1E']
  --   ['--color', 'gutter:#3E3D32']
  -- }
  files = {
    cmd = "fd --type f --hidden --follow --exclude .git --exclude .snapshots --exclude var --exclude opt --exclude lib --exclude lib64 --exclude mnt --exclude proc --exclude run --exclude sbin --exclude srv --exclude sys --exclude tmp",
  },
  winopts = {
    -- hl = {
    --   border = "FloatBorder",
    --   cursorline = "FloatBorder",
    --   cursor = "FloatBorder",
    -- },
    height = 0.55,
    width = 0.50,
    border = 'rounded', -- or 'double', 'rounded', 'sharp', etc.
    -- other window options
    preview = {
      hidden = 'hidden', -- Disable the preview window
    },
  },
}

vim.api.nvim_set_keymap("n", "<leader>ff", ":lua vim.cmd('FzfLua files')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ":FzfLua files cwd=~/<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fr", ":FzfLua files cwd=/<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fs", ":FzfLua grep_project<CR>", { noremap = true })

vim.keymap.set({ "i" }, "<C-y>",
  function() require("fzf-lua").complete_path({
    cmd = "fd --hidden . / --follow --exclude .git --exclude .snapshots --exclude var --exclude opt --exclude lib --exclude lib64 --exclude mnt --exclude proc --exclude run --exclude sbin --exclude srv --exclude sys --exclude tmp",
  }) end,
  { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set({ "i" }, "<C-l>", function()
  -- Get the current line and cursor position
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Get the path fragment to the left of the cursor
  local path_fragment = line:sub(1, col):match("([^%s]+)$")

  -- If there's no path fragment found, default to searching from the current directory
  if not path_fragment or path_fragment == "" then
    path_fragment = "."
  end

  -- Run the fd command with the dynamic path fragment
  require("fzf-lua").complete_path({
    cmd = string.format("fd --hidden", vim.fn.shellescape(path_fragment))
  })
end, { silent = true, desc = "Fuzzy complete path" })


vim.g.fzf_colors = {
  ["fg"] = {"fg", "Normal"},
  ["bg"] = {"bg", "Normal"},
  ["hl"] = {"fg", "Comment"},
  ["fg+"] = {"fg", "CursorLine", "CursorColumn", "Normal"},
  ["bg+"] = {"bg", "CursorLine", "CursorColumn"},
  ["hl+"] = {"fg", "Statement"},
  ["info"] = {"fg", "PreProc"},
  ["border"] = {"fg", "Ignore"},
  ["prompt"] = {"fg", "Conditional"},
  ["pointer"] = {"fg", "Exception"},
  ["marker"] = {"fg", "Keyword"},
  ["spinner"] = {"fg", "Label"},
  ["header"] = {"fg", "Comment"}
}
