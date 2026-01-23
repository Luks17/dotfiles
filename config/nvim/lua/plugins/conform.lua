return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        local conform = require('conform')

        local js_related_options = { 'prettierd', 'prettier', stop_after_first = true }

        conform.setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                go = { 'golangci-lint' },
                python = { 'isort', 'black' },
                rust = { 'rustfmt' },
                javascript = js_related_options,
                typescript = js_related_options,
                typescriptreact = js_related_options,
                json = js_related_options,
                json5 = js_related_options,
                sql = { 'sqlfluff' },
                pgsql = { 'sqlfluff' },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = 'fallback',
            },
            formatters = {
                sqlfluff = {
                    command = 'sqlfluff',
                    args = { 'fix', '--dialect=postgres', '-n', '-' },
                    stdin = true,
                    cwd = function() return vim.fn.getcwd() end,
                },
            },
        })
    end,
}
