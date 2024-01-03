local cmp = require'cmp'

cmp.setup {
  sources = {
    { name = 'path' },
  },
  mapping = {
   ['<C-a>'] = cmp.mapping.confirm({ select = true }),
  },
}


-- -- cmdline setup
-- cmp.setup.cmdline(':', {
--   mappings = cmp.mapping.preset.cmdline(),
--   options = {
--     ignore_cmds = { 'Man', '!' }
--   }
-- })
