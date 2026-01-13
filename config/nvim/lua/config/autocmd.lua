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

local codelenses_group = vim.api.nvim_create_augroup('CodeLenses', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = codelenses_group,
    desc = 'Refresh codelens on LSP attach if supported',
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
