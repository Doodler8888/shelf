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

vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>lua OpenFloatingTermInCurrentDir()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>ToggleTerm<CR>', {noremap = true, silent = true})




function _G.switch_to_next_toggleterm()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    local found_current = false
    for _, buf in ipairs(bufs) do
        if vim.bo[buf].ft == 'toggleterm' then
            if found_current then
                -- Switch to the next toggleterm buffer
                vim.api.nvim_set_current_buf(buf)
                return
            elseif buf == current_buf then
                found_current = true
            end
        end
    end
    if found_current then
        -- If the current buffer is the last toggleterm, switch to the first one
        for _, buf in ipairs(bufs) do
            if vim.bo[buf].ft == 'toggleterm' then
                vim.api.nvim_set_current_buf(buf)
                return
            end
        end
    end
end


vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
        -- Set keymap for 'Ctrl-w h' in insert mode within the terminal buffer
        vim.api.nvim_buf_set_keymap(0, 't', '<C-w>h', '<cmd>lua switch_to_next_toggleterm()<CR>', {noremap = true, silent = true})
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-w>h', '<cmd>lua switch_to_next_toggleterm()<CR>', {noremap = true, silent = true})
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  command = "startinsert"
})
