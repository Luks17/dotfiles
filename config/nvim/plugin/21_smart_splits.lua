Setup.later(function()
    vim.pack.add({
        {
            src = 'https://github.com/mrjones2014/smart-splits.nvim',
            version = vim.version.range('v3.*'),
        },
        {
            src = 'https://github.com/adriankarlen/smart-splits-backend-herdr',
        },
    })

    local smart_splits = require('smart-splits')
    smart_splits.setup({
        mux = { backend = 'smart-splits-backend-herdr' },
    })

    MapSet('n', '<C-h>', smart_splits.move_cursor_left)
    MapSet('n', '<C-j>', smart_splits.move_cursor_down)
    MapSet('n', '<C-k>', smart_splits.move_cursor_up)
    MapSet('n', '<C-l>', smart_splits.move_cursor_right)

    MapSet('n', '<A-h>', smart_splits.resize_left)
    MapSet('n', '<A-j>', smart_splits.resize_down)
    MapSet('n', '<A-k>', smart_splits.resize_up)
    MapSet('n', '<A-l>', smart_splits.resize_right)

    MapSet('n', '<A-Left>', smart_splits.resize_left)
    MapSet('n', '<A-Down>', smart_splits.resize_down)
    MapSet('n', '<A-Up>', smart_splits.resize_up)
    MapSet('n', '<A-Right>', smart_splits.resize_right)
end)
