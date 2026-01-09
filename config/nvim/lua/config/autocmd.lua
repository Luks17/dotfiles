-- When editing a file, always jump to the last known cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1
            and vim.fn.line([['"]]) < vim.fn.line('$')
        local not_commit = vim.b[args.buf].filetype ~= 'commit'

        if valid_line and not_commit then vim.cmd([[normal! g`"]]) end
    end,
})

-- When closing last buffer that was not created by a plugin, open Dashboard
vim.api.nvim_create_augroup('DashboardOnEmpty', { clear = true })
vim.api.nvim_create_autocmd('BufDelete', {
    group = 'DashboardOnEmpty',
    callback = function()
        -- run after the delete has finished
        vim.schedule(function()
            local bufs = vim.api.nvim_list_bufs()
            local actual = {}

            for _, b in ipairs(bufs) do
                -- only consider listed buffers (ignores ephemeral/unlisted ones)
                if vim.fn.buflisted(b) == 1 then
                    local ok, buftype =
                        pcall(vim.api.nvim_buf_get_option, b, 'buftype')
                    if ok and buftype ~= 'nofile' then table.insert(actual, b) end
                end
            end

            -- require exactly one "real" buffer left
            if #actual ~= 1 then return end

            local last_buf = actual[1]
            local name = vim.api.nvim_buf_get_name(last_buf)

            if name == '' then require('mini.starter').open() end
        end)
    end,
})

-- remove stray unnamed buffers once a real buffer opens
vim.api.nvim_create_augroup('CleanupUnnamed', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWinEnter' }, {
    group = 'CleanupUnnamed',
    callback = function()
        local cur = vim.api.nvim_get_current_buf()

        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if b ~= cur and vim.fn.buflisted(b) == 1 then
                local ok, buftype = pcall(vim.api.nvim_buf_get_option, b, 'buftype')
                if ok then
                    local name = vim.api.nvim_buf_get_name(b)
                    if
                        (name == '' or name == '*')
                        and (buftype == '' or buftype == 'nofile')
                    then
                        pcall(vim.api.nvim_buf_delete, b, { force = true })
                    end
                end
            end
        end
    end,
})
