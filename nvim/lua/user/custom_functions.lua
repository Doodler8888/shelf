function Copy_full_path()
    local full_path = vim.fn.expand('%:p')
    vim.fn.setreg('+', full_path)
    print('Copied path: ' .. full_path)
end

vim.api.nvim_create_user_command('Cp', Copy_full_path, {})


function TrimLeadingWhitespace()
    -- Get the current line number
    local line_num = vim.api.nvim_win_get_cursor(0)[1]

    -- Get the current line content
    local line = vim.api.nvim_buf_get_lines(0, line_num-1, line_num, false)[1]

    -- Remove leading whitespace
    local trimmed_line = line:gsub("^%s*", "")

    -- Set the trimmed line back
    vim.api.nvim_buf_set_lines(0, line_num-1, line_num, false, {trimmed_line})

    -- Move the cursor to the start of the line
    vim.api.nvim_win_set_cursor(0, {line_num, 0})
end

-- Map the function to Ctrl+d in insert mode
vim.api.nvim_set_keymap('i', '<C-d>', '<cmd>lua TrimLeadingWhitespace()<CR>', { noremap = true, silent = true })
