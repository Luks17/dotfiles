Setup.later(function()
    vim.pack.add({
        'https://github.com/nvim-neotest/neotest',
        'https://github.com/marilari88/neotest-vitest',
        'https://github.com/fredrikaverpil/neotest-golang',

        -- deps
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/nvim-lua/plenary.nvim',
    })

    local neotest = require('neotest')
    neotest.setup({
        adapters = {
            require('neotest-vitest'),
            require('neotest-golang')({
                runner = 'gotestsum',
            }),
        },
    })

    MapSet('n', '<leader>tr', neotest.run.run, 'Run nearest test')
    MapSet('n', '<leader>tS', neotest.run.run, 'Stop nearest test')
    MapSet('n', '<leader>td', function() neotest.run.run({ strategy = 'dap' }) end, 'Debug nearest test')
    MapSet('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, 'Test entire file')
    MapSet('n', '<leader>tw', function() neotest.run.run(vim.fn.getcwd()) end, 'Test entire workspace')
    MapSet('n', '<leader>to', neotest.output.open, 'Test output')
    MapSet('n', '<leader>tO', neotest.output_panel.toggle, 'Toggle tests output panel')
    MapSet('n', '<leader>ts', neotest.summary.toggle, 'Toggle test summary')
end)
