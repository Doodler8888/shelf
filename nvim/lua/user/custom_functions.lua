function Copy_full_path()
    local full_path = vim.fn.expand('%:p')
    vim.fn.setreg('+', full_path)
    print('Copied path: ' .. full_path)
end

vim.api.nvim_create_user_command('Cp', Copy_full_path, {})


function TrimWhitespace()
    -- Get the current line number and column
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line_num = cursor_pos[1]
    local col_num = cursor_pos[2]

    -- Get the current line content
    local line = vim.api.nvim_buf_get_lines(0, line_num-1, line_num, false)[1]

    -- Split the line at the cursor's position
    local first_part = line:sub(1, col_num)
    local second_part = line:sub(col_num + 1)

    -- Trim the whitespace from the end of the first part
    first_part = first_part:gsub("%s*$", "")

    -- Join the parts back together
    local trimmed_line = first_part .. second_part

    -- Set the trimmed line back
    vim.api.nvim_buf_set_lines(0, line_num-1, line_num, false, {trimmed_line})

    -- Move the cursor to the end of the trimmed first part
    vim.api.nvim_win_set_cursor(0, {line_num, #first_part})
end

vim.api.nvim_set_keymap('i', '<C-d>', '<cmd>lua TrimWhitespace()<CR>', { noremap = true, silent = true })


-- local function change_to_buffer_dir()
--   -- Get the current buffer's full path
--   local bufname = vim.api.nvim_buf_get_name(0)
--   -- Extract the directory from the buffer's full path
--   local buftdir = vim.fn.fnamemodify(bufname, ':p:h')
--   -- Change the Neovim's current working directory to the buffer's directory
--   vim.cmd('cd ' .. buftdir)
-- end

local function change_to_buffer_dir()
  -- Check if the current buffer is a netrw buffer
  local is_netrw = vim.fn.exists("g:netrw_dir") == 1
  local buftdir

  if is_netrw then
    -- In netrw, the current directory is stored in a global variable
    buftdir = vim.g.netrw_dir
  else
    -- Get the current buffer's full path
    local bufname = vim.api.nvim_buf_get_name(0)
    -- Extract the directory from the buffer's full path
    buftdir = vim.fn.fnamemodify(bufname, ':p:h')
  end

  -- Change Neovim's current working directory to the buffer's directory
  vim.cmd('cd ' .. buftdir)
end

-- Create a Neovim command called "CdToBufferDir" that invokes the function
vim.api.nvim_create_user_command('Cd', change_to_buffer_dir, {})


-- Define the custom 'f' function for normal and operator-pending mode
local function custom_find_next_char(char, op_mode)
    local current_pos = vim.api.nvim_win_get_cursor(0)
    local found = false
    local line_count = vim.api.nvim_buf_line_count(0)

    while current_pos[1] <= line_count and not found do
        -- Perform the 'f' action with the provided character
        vim.cmd('normal! f' .. char)
        local new_pos = vim.api.nvim_win_get_cursor(0)
        if new_pos[1] ~= current_pos[1] or new_pos[2] ~= current_pos[2] then
            found = true
        else
            if op_mode then
                -- If in operator-pending mode, extend the selection to the next line
                vim.cmd('normal! j^')
            else
                -- Move to the first non-blank character of the next line
                vim.cmd('normal! j0')
            end
            current_pos = vim.api.nvim_win_get_cursor(0)
        end
    end
end

-- Create a Lua function that waits for the next key press and calls 'custom_find_next_char'
local function custom_find_f(op_mode)
    local char = vim.fn.nr2char(vim.fn.getchar())
    custom_find_next_char(char, op_mode)
end

-- Map the 'f' key to the custom Lua function for normal and operator-pending mode
vim.api.nvim_set_keymap('n', 'f', '', { noremap = true, silent = true, callback = function() custom_find_f(false) end })
vim.api.nvim_set_keymap('x', 'f', '', { noremap = true, silent = true, callback = function() custom_find_f(false) end })
vim.api.nvim_set_keymap('o', 'f', '', { noremap = true, silent = true, callback = function() custom_find_f(true) end })


-- Define the custom 'F' function for normal and operator-pending mode
local function custom_find_prev_char(char, op_mode)
    local current_pos = vim.api.nvim_win_get_cursor(0)
    local found = false

    while current_pos[1] >= 1 and not found do
        -- Perform the 'F' action with the provided character
        vim.cmd('normal! F' .. char)
        local new_pos = vim.api.nvim_win_get_cursor(0)
        if new_pos[1] ~= current_pos[1] or new_pos[2] ~= current_pos[2] then
            found = true
        else
            if op_mode then
                -- If in operator-pending mode, extend the selection to the previous line
                vim.cmd('normal! k$')
            else
                -- Move to the last non-blank character of the previous line
                vim.cmd('normal! k$')
            end
            current_pos = vim.api.nvim_win_get_cursor(0)
        end
    end
end

-- Create a Lua function that waits for the next key press and calls 'custom_find_prev_char'
local function custom_find_F(op_mode)
    local char = vim.fn.nr2char(vim.fn.getchar())
    custom_find_prev_char(char, op_mode)
end

-- Map the 'F' key to the custom Lua function for normal and operator-pending mode
vim.api.nvim_set_keymap('n', 'F', '', { noremap = true, silent = true, callback = function() custom_find_F(false) end })
vim.api.nvim_set_keymap('x', 'F', '', { noremap = true, silent = true, callback = function() custom_find_F(false) end })
vim.api.nvim_set_keymap('o', 'F', '', { noremap = true, silent = true, callback = function() custom_find_F(true) end })


-- Define the custom 't' function for normal and operator-pending mode
local function custom_to_before_char(char, op_mode)
   local current_pos = vim.api.nvim_win_get_cursor(0)
   local found = false
   local line_count = vim.api.nvim_buf_line_count(0)

   while current_pos[1] <= line_count and not found do
       -- Perform the 't' action with the provided character
       vim.cmd('normal! t' .. char)
       local new_pos = vim.api.nvim_win_get_cursor(0)
       if new_pos[1] ~= current_pos[1] or new_pos[2] ~= current_pos[2] then
           found = true
       else
           if op_mode then
               -- If in operator-pending mode, extend the selection to the next line
               vim.cmd('normal! j^')
           else
               -- Move to the first non-blank character of the next line
               vim.cmd('normal! j0')
           end
           current_pos = vim.api.nvim_win_get_cursor(0)
       end
   end
end

-- Create a Lua function that waits for the next key press and calls 'custom_to_before_char'
local function custom_to_t(op_mode)
   local char = vim.fn.nr2char(vim.fn.getchar())
   custom_to_before_char(char, op_mode)
end

-- Map the 't' key to the custom Lua function for normal and operator-pending mode
vim.api.nvim_set_keymap('n', 't', '', { noremap = true, silent = true, callback = function() custom_to_t(false) end })
vim.api.nvim_set_keymap('x', 't', '', { noremap = true, silent = true, callback = function() custom_to_t(false) end })
vim.api.nvim_set_keymap('o', 't', '', { noremap = true, silent = true, callback = function() custom_to_t(true) end })

-- Similarly, for 'T' command
local function custom_to_after_char(char, op_mode)
   local current_pos = vim.api.nvim_win_get_cursor(0)
   local found = false

   while current_pos[1] >= 1 and not found do
       -- Perform the 'T' action with the provided character
       vim.cmd('normal! T' .. char)
       local new_pos = vim.api.nvim_win_get_cursor(0)
       if new_pos[1] ~= current_pos[1] or new_pos[2] ~= current_pos[2] then
           found = true
       else
           if op_mode then
               -- If in operator-pending mode, extend the selection to the previous line
               vim.cmd('normal! k$')
           else
               -- Move to the last non-blank character of the previous line
               vim.cmd('normal! k$')
           end
           current_pos = vim.api.nvim_win_get_cursor(0)
       end
   end
end

-- Create a Lua function that waits for the next key press and calls 'custom_to_after_char'
local function custom_to_T(op_mode)
   local char = vim.fn.nr2char(vim.fn.getchar())
   custom_to_after_char(char, op_mode)
end

-- Map the 'T' key to the custom Lua function for normal and operator-pending mode
vim.api.nvim_set_keymap('n', 'T', '', { noremap = true, silent = true, callback = function() custom_to_T(false) end })
vim.api.nvim_set_keymap('x', 'T', '', { noremap = true, silent = true, callback = function() custom_to_T(false) end })
vim.api.nvim_set_keymap('o', 'T', '', { noremap = true, silent = true, callback = function() custom_to_T(true) end })

