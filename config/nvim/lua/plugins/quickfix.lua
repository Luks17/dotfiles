-- Makes quickfix not suck
return {
    'stevearc/quicker.nvim',
    event = 'BufFilePre',
    dependencies = {
        {
            'kevinhwang91/nvim-bqf',
            ft = 'qf',
            opts = {},
        },
    },
    opts = {},
    config = function()
        local quicker = require('quicker')
        quicker.setup({
            keys = {
                {
                    '>',
                    function()
                        quicker.expand({
                            before = 2,
                            after = 2,
                            add_to_existing = true,
                        })
                    end,
                    desc = 'Expand quickfix context',
                },
                {
                    '<',
                    function() quicker.collapse() end,
                    desc = 'Collapse quickfix context',
                },
            },
        })

        MapSet(
            'n',
            '<leader>xq',
            function() quicker.toggle({ focus = true }) end,
            'Toggle quickfix'
        )
        MapSet(
            'n',
            '<leader>xl',
            function() quicker.toggle({ focus = true, loclist = true }) end,
            'Toggle location list'
        )
    end,
}
