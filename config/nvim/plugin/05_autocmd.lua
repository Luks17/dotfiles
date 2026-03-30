Setup.new_autocmd('BufReadPost', {}, function(args)
    local line = vim.fn.line([['"]])
    local valid_line = line >= 1 and line <= vim.fn.line('$')
    local not_commit = vim.b[args.buf].filetype ~= 'commit'

    if valid_line and not_commit then vim.cmd([[normal! g`"]]) end
end, 'Jump to last known cursor position on file')
