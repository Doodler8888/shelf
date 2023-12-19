require("user")

vim.o.clipboard = "unnamedplus"

-- Terraform ls
vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead *.tf setfiletype terraform
]], false)

-- vim.g.codeium_no_map_tab = 1

vim.cmd [[
  command! StopAllLSP lua for _, client in ipairs(vim.lsp.get_active_clients()) do vim.lsp.stop_client(client) end
]]
