-- Global variable to store the session directory
SessionDir = nil

-- Global variable to store if a session is loaded
SessionLoaded = false


function SetSessionDir()
  local current_dir = vim.fn.getcwd()
  local new_dir = vim.fn.input('Set session directory: ', current_dir, 'dir')

  -- Check if the input is not empty
  if new_dir ~= '' then
    SessionDir = new_dir
    -- Add a newline character before the message
    print('\nSession directory set to: ' .. SessionDir)
  else
    print('\nSession directory unchanged.')
  end
end

-- Function to find the session directory
function FindSessionDir()
  if SessionDir ~= nil then
    return SessionDir
  else
    local current_dir = vim.fn.getcwd()
    while true do
      local session_file = current_dir .. '/.session'
      if vim.fn.filereadable(session_file) == 1 then
        return current_dir
      else
        -- Move up one directory level
        local parent_dir = vim.fn.fnamemodify(current_dir, ':h')
        if parent_dir == current_dir then
          -- Reached the root directory, stop searching
          break
        end
        current_dir = parent_dir
      end
    end
  end
  print('No session file found in any parent directories')
  return nil
end

function CloseAllToggleTermBuffers()
    -- Iterate over all buffers
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        -- Check if the buffer is valid and loaded to avoid errors
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
            local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
            -- Check if the buffer is a terminal
            if buftype == "terminal" then
                -- Attempt to close the terminal buffer
                -- This command closes the buffer ignoring unsaved changes. Be cautious.
                vim.api.nvim_buf_delete(buf, {force = true})
            end
        end
    end
end

-- Function to save the session with an additional parameter to indicate autosave
function SaveSession(autosave)
  -- If autosave is true and no session was loaded, skip saving
  if autosave and not SessionLoaded then
    print('No session was loaded, so no session will be saved on exit.')
    return
  end

  local root_dir = FindSessionDir()
  if root_dir then
    local session_file = root_dir .. '/.session'
    vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
    print('Session saved to: ' .. session_file)
  end
end



-- Modified load_session function to return a boolean
function LoadSession()
  local root_dir = FindSessionDir()
  if root_dir then
    local session_file = root_dir .. '/.session'
    if vim.fn.filereadable(session_file) == 1 then
      vim.cmd('source ' .. vim.fn.fnameescape(session_file))
      print('Session loaded from: ' .. session_file)
      SessionLoaded = true -- Set the flag to true when a session is loaded
      return true
    else
      print('Session file not found: ' .. session_file)
    end
  end
  return false
end


function AutoloadSession()
  vim.defer_fn(function()
    local root_dir = FindSessionDir()
    if root_dir then
      local session_file = root_dir .. '/.session'
      if vim.fn.filereadable(session_file) == 1 then
        -- Check for floating windows
        local has_float = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            has_float = true
            break
          end
        end

        -- If no floating window is present, show the session loading prompt
        if not has_float then
          print('Press "Enter" to load a session.')
          local char = vim.fn.getchar()
          if char == 13 then
            vim.cmd('source ' .. vim.fn.fnameescape(session_file))
            print('Session loaded from: ' .. session_file)
            SessionLoaded = true  -- Ensure SessionLoaded is set to true
          else
            print('Invalid input. Session not loaded.')
          end
        else
          print('A floating window is present. Session prompt skipped.')
        end
      else
        print('No session file found at ' .. session_file .. '. Prompt skipped.')
      end
    else
      print('No session directory set. Prompt skipped.')
    end
  end, 100) -- Delay in milliseconds, adjust as needed
end


-- Set up an autocommand to call AutoloadSession when Neovim has finished starting up
vim.api.nvim_create_autocmd("VimEnter", {
  callback = AutoloadSession
})

-- -- Call AutoloadSession when Neovim starts
-- AutoloadSession()

-- Update the command names to avoid any conflicts and ensure they are unique
vim.api.nvim_create_user_command('SaveSession', SaveSession, {})
vim.api.nvim_create_user_command('OpenSession', LoadSession, {})

-- Key binding for setting the session directory
vim.api.nvim_set_keymap('n', '<leader>sd', ':lua SetSessionDir()<CR>', { noremap = true, silent = true })

-- Key binding for OpenSession
vim.api.nvim_set_keymap('n', '<leader>sl', ':OpenSession<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function() SaveSession(true) end
})

-- Update the command to pass false for manual saves
vim.api.nvim_create_user_command('SaveSession', function() SaveSession(false) end, {})

-- Ensure key bindings for saving sessions also indicate manual saves
vim.api.nvim_set_keymap('n', '<leader>ss', ':lua SaveSession(false)<CR>', { noremap = true, silent = true })
