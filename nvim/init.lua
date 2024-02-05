require("user")

vim.api.nvim_create_augroup("YAMLAutoIndentOff", { clear = true })

-- Create an autocommand within the previously defined group. This command targets YAML files
-- (identified by the filetype 'yaml') and sets the 'autoindent' option to false for those files.
vim.api.nvim_create_autocmd("FileType", {
    group = "YAMLAutoIndentOff",
    pattern = "yaml",
    callback = function()
        -- Disable auto indentation for YAML files
        vim.opt_local.autoindent = false
        -- Additionally, you might want to disable smart indentation as well
        vim.opt_local.smartindent = false
    end,
})
