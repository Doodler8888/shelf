local Hydra = require('hydra')

Hydra({
    name = 'Resize Window',
    mode = 'n',  -- Normal mode
    body = '<C-w>',  -- This is your prefix key
    heads = {
        { '+', '3<C-w>+', { desc = 'Increase height' }},
        { '-', '3<C-w>-', { desc = 'Decrease height' }},
        { '<', '5<C-w><', { desc = 'Decrease width' }},
        { '>', '5<C-w>>', { desc = 'Increase width' }},
        -- Add other commands or heads as needed
        { 'q', nil, { exit = true, desc = 'Quit Hydra' }},  -- Exit the Hydra
    }
})

