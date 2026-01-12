return {
    {
        '3rd/image.nvim',
        build = false,
        event = 'BufFilePre',
        opts = {
            processor = 'magick_cli',
        },
    },
    {
        'HakonHarnes/img-clip.nvim',
        event = 'BufFilePre',
        opts = {},
        keys = { '<C-p>', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
}
