Setup.later(function()
    vim.pack.add({
        {
            src = 'https://github.com/saghen/blink.cmp',
            version = vim.version.range('v1.*'),
        },

        -- deps
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
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        cmdline = {
            enabled = true,
        },
    })
end)
