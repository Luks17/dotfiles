return {
    'mrjones2014/smart-splits.nvim',
    config = function()
        local smart_splits = require('smart-splits')

        MapSet('n', '<C-Left>', smart_splits.move_cursor_left)
        MapSet('n', '<C-Down>', smart_splits.move_cursor_down)
        MapSet('n', '<C-Up>', smart_splits.move_cursor_up)
        MapSet('n', '<C-Right>', smart_splits.move_cursor_right)

        MapSet('n', '<A-Left>', smart_splits.resize_left)
        MapSet('n', '<A-Down>', smart_splits.resize_down)
        MapSet('n', '<A-Up>', smart_splits.resize_up)
        MapSet('n', '<A-Right>', smart_splits.resize_right)
    end,
}
