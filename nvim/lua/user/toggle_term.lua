require('toggleterm').setup{
  size = 20, -- or use a function to calculate size dynamically
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  -- direction = 'float',
  -- close_on_exit = true,
  -- float_opts = {
  --   border = 'single',
  --   width = math.floor(vim.o.columns * 0.8),
  --   height = math.floor(vim.o.lines * 0.8),
  -- },
}

function OpenFloatingTermInCurrentDir()
    local buf_dir = vim.fn.expand('%:p:h')

    -- Use the Terminal:new API to create a new terminal instance with the desired parameters
    local Terminal  = require('toggleterm.terminal').Terminal
    local floating_term = Terminal:new({
        dir = buf_dir,
        direction = "float",
        -- You can specify other parameters here as needed
        float_opts = {
            border = 'single',
            width = math.floor(vim.o.columns * 0.47),
            height = math.floor(vim.o.lines * 0.47),
        },
    })

    -- Toggle (open/close) the terminal
    floating_term:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua OpenFloatingTermInCurrentDir()<CR>', {noremap = true, silent = true})
