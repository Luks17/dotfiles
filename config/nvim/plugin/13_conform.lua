Setup.later(function()
    vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

    local conform = require('conform')

    local js_related_options = { 'prettierd', 'prettier', stop_after_first = true }

    conform.setup({
        formatters_by_ft = {
            lua = { 'stylua' },
            go = { 'goimports', 'gofumpt' },
            python = { 'isort', 'black' },
            rust = { 'rustfmt' },
            javascript = js_related_options,
            typescript = js_related_options,
            typescriptreact = js_related_options,
            json = js_related_options,
            json5 = js_related_options,
            sql = { 'sqruff', lsp_format = 'never' },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
        formatters = {
            sqruff = {
                args = { 'fix', '$FILENAME' },
            },
        },
    })
end)
