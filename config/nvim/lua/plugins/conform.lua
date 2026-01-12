return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                go = { 'golangci-lint', 'gofumpt', stop_after_first = true },
                python = { 'isort', 'black' },
                rust = { 'rustfmt' },
                javascript = { 'prettierd', 'prettier', stop_after_first = true },
                typescript = { 'prettierd', 'prettier', stop_after_first = true },
                typescriptreact = {
                    'prettierd',
                    'prettier',
                    stop_after_first = true,
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = 'fallback',
            },
        })
    end,
}
