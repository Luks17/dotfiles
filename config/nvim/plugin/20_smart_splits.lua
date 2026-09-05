Setup.later(function()
    vim.pack.add({ 'https://github.com/mrjones2014/smart-splits.nvim' })

    local smart_splits = require('smart-splits')

    MapSet('n', '<C-h>', smart_splits.move_cursor_left)
    MapSet('n', '<C-j>', smart_splits.move_cursor_down)
    MapSet('n', '<C-k>', smart_splits.move_cursor_up)
    MapSet('n', '<C-l>', smart_splits.move_cursor_right)

    MapSet('n', '<A-h>', smart_splits.resize_left)
    MapSet('n', '<A-j>', smart_splits.resize_down)
    MapSet('n', '<A-k>', smart_splits.resize_up)
    MapSet('n', '<A-l>', smart_splits.resize_right)
end)
