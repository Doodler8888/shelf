local cmp = require'cmp'

-- main cmp setup
cmp.setup {
  sources = {
    { name = 'path' },
    { name = 'cmdline' }
  }
}

-- cmdline setup
cmp.setup.cmdline(':', {
  mappings = cmp.mapping.preset.cmdline(),
  options = {
    ignore_cmds = { 'Man', '!' }
  }
})
