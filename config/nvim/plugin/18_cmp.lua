Setup.later(function()
    vim.pack.add({
        {
            src = 'https://github.com/saghen/blink.cmp',
            version = vim.version.range('v1.*'),
        },

        'https://github.com/rafamadriz/friendly-snippets',
    })

    require('blink.cmp').setup({
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C><leader>'] = { 'show' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            documentation = { auto_show = true },
            menu = {
                draw = {
                    columns = {
                        { 'kind_icon', gap = 1 },
                        { 'label', 'label_description', gap = 1 },
                        { 'kind' },
                    },
                },
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        cmdline = {
            enabled = true,
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon', gap = 1 },
                            { 'label', 'label_description', gap = 1 },
                        },
                    },
                },
            },
        },
    })
end)
