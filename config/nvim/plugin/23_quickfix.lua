Setup.later(function()
    vim.pack.add({
        'https://github.com/kevinhwang91/nvim-bqf',
        'https://github.com/stevearc/quicker.nvim',
    })

    require('bqf').setup()
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

    MapSet('n', '<leader>oxq', function() quicker.toggle({ focus = true }) end, 'Toggle quickfix')
    MapSet('n', '<leader>oxl', function() quicker.toggle({ focus = true, loclist = true }) end, 'Toggle location list')
end)
