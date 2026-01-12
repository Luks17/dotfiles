return {
    {
        '3rd/image.nvim',
        build = false,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            processor = 'magick_cli',
        },
    },
    {
        'HakonHarnes/img-clip.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
        keys = { '<C-p>', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
}
