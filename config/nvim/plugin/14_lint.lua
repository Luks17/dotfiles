Setup.later(function()
    vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

    local lint = require('lint')
    lint.linters_by_ft = {
        dockerfile = { 'hadolint' },
        sql = { 'sqruff' },
    }

    Setup.new_autocmd(
        { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
        {},
        function() lint.try_lint() end,
        'Lint file on save'
    )
end)
