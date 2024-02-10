vim.o.packpath = "/tmp/nvim/site"

local plugins = {
  rose_pine = "https://github.com/stevearc/resession.nvim",
  -- ADD OTHER PLUGINS _NECESSARY_ TO REPRODUCE THE ISSUE
}

for name, url in pairs(plugins) do
  local install_path = "/tmp/nvim/site/pack/test/start/" .. name
  if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system({ "git", "clone", "--depth=1", url, install_path })
  end
end


require("resession").setup({
  autosave = {
    enabled = true,
    interval = 30,
    notify = false,
  },
})

local resession = require("resession")
resession.setup()
-- Resession does NOTHING automagically, so we have to set up some keymaps
vim.keymap.set("n", "<leader>ss", resession.save)
vim.keymap.set("n", "<leader>sl", resession.load)
vim.keymap.set("n", "<leader>sd", resession.delete)

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if require('resession').is_loading() then
      require('resession').save()
    end
  end,
})
