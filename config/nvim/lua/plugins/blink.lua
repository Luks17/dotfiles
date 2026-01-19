return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    event = { 'VeryLazy' },
    opts = {
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C><leader>'] = { 'show' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = { documentation = { auto_show = true } },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        cmdline = {
            completion = {
                menu = {
                    auto_show = function() return vim.fn.getcmdtype() == ':' end,
                },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
