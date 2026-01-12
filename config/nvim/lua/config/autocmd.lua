local last_cursor_position_group = vim.api.nvim_create_augroup('LastCursorPosition', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    group = last_cursor_position_group,
    desc = 'Jump to last known cursor position on file',
    callback = function(args)
        local line = vim.fn.line([['"]])
        local valid_line = line >= 1 and line <= vim.fn.line('$')
        local not_commit = vim.b[args.buf].filetype ~= 'commit'

        if valid_line and not_commit then vim.cmd([[normal! g`"]]) end
    end,
})

-- When closing last buffer that was not created by a plugin, open Dashboard
local dashboard_on_empty_group = vim.api.nvim_create_augroup('DashboardOnEmpty', { clear = true })
vim.api.nvim_create_autocmd('BufDelete', {
    group = dashboard_on_empty_group,
    desc = 'Open Dashboard when last buffer is deleted',
    callback = function()
        -- run after the delete has finished
        vim.schedule(function()
            local bufs = vim.api.nvim_list_bufs()
            local actual = {}

            for _, b in ipairs(bufs) do
                -- only consider listed buffers (ignores ephemeral/unlisted ones)
                if vim.fn.buflisted(b) == 1 then
                    local ok, buftype = pcall(function() return vim.bo[b].buftype end)
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
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWinEnter' }, {
    group = dashboard_on_empty_group,
    callback = function()
        local cur = vim.api.nvim_get_current_buf()

        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if b ~= cur and vim.fn.buflisted(b) == 1 then
                local ok, buftype = pcall(function() return vim.bo[b].buftype end)
                if ok then
                    local name = vim.api.nvim_buf_get_name(b)
                    if (name == '' or name == '*') and (buftype == '' or buftype == 'nofile') then
                        pcall(vim.api.nvim_buf_delete, b, { force = true })
                    end
                end
            end
        end
    end,
})

-- start codelens on LSP attach if LSP supports it
local codelenses_group = vim.api.nvim_create_augroup('CodeLenses', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = codelenses_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or not client:supports_method('textDocument/codeLens') then return end

        local bufnr = args.buf

        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(bufnr) then vim.lsp.codelens.refresh({ bufnr = bufnr }) end
        end)

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
            group = codelenses_group,
            buffer = bufnr,
            callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
        })
    end,
})
