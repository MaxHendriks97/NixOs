vim.api.nvim_create_autocmd({ "BufwritePre" }, {
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear=true }),
    desc = "Remove all trailing whitespace on save",
    pattern = { "*" },
    callback = function ()
        local save_cursor = vim.fn.getpos(".")
        pcall(function ()
            vim.cmd([[%s/\s\+$//e]])
        end)
        vim.fn.setpos(".", save_cursor)
    end,
})

vim.api.nvim_create_autocmd("QuitPre", {
    group = vim.api.nvim_create_augroup("WindowsCleanUp", { clear=true }),
    callback = function ()
        os.execute('del /Q "%LOCALAPPDATA%\\nvim-data\\shada\\main.shada.tmp.*"')
    end
})
