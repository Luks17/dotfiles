Setup.later(function()
    vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

    local lint = require('lint')
    lint.linters_by_ft = {}

    Setup.new_autocmd('BufWritePost', {}, function() lint.try_lint() end, 'Lint file on save')
end)
